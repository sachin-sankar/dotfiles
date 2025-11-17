#!/usr/bin/env python3
import qbittorrentapi
import time

# Configuration
HOST = "localhost"
PORT = 8080
USERNAME = "admin"
PASSWORD = "adminadmin"  # Change this to your password
SPEED_THRESHOLD = 250 * 1024  # 250 KiB/s converted to bytes/s
CHECK_INTERVAL = 2  # Check every 2 seconds
COOLDOWN_PERIOD = 30  # Cooldown period in seconds after restart action

# Global variable to track last restart time
last_restart_time = 0


def is_cooldown_active():
    """Check if we're still in cooldown period"""
    global last_restart_time
    time_since_restart = time.time() - last_restart_time
    return time_since_restart < COOLDOWN_PERIOD


def get_cooldown_remaining():
    """Get remaining cooldown time in seconds"""
    global last_restart_time
    elapsed = time.time() - last_restart_time
    remaining = COOLDOWN_PERIOD - elapsed
    return max(0, remaining)


def check_and_restart_if_slow(qbt_client):
    """Check download speed and restart torrents if below threshold"""
    global last_restart_time

    try:
        transfer_info = qbt_client.transfer_info()
        current_speed = transfer_info.dl_info_speed  # Download speed in bytes/s

        print(
            f"[{time.strftime('%H:%M:%S')}] Current download speed: {current_speed / 1024:.2f} KiB/s"
        )

        # Check if speed is below threshold
        if current_speed < SPEED_THRESHOLD:
            # Check if cooldown is active
            if is_cooldown_active():
                remaining = get_cooldown_remaining()
                print(
                    f"  ⏳ Speed below threshold but cooldown active ({remaining:.1f}s remaining)"
                )
                return

            print(f"  ⚠ Speed is below threshold ({SPEED_THRESHOLD / 1024:.2f} KiB/s)")

            # Pause all downloads
            print("  → Pausing all torrents...")
            try:
                qbt_client.torrents.stop.all()
                print("  ✓ All torrents paused (using stop)")
            except AttributeError:
                qbt_client.torrents.pause.all()
                print("  ✓ All torrents paused (using pause)")

            # Wait 5 seconds
            print("  → Waiting 5 seconds...")
            time.sleep(5)

            # Resume all downloads
            print("  → Resuming all torrents...")
            try:
                qbt_client.torrents.start.all()
                print("  ✓ All torrents resumed (using start)")
            except AttributeError:
                qbt_client.torrents.resume.all()
                print("  ✓ All torrents resumed (using resume)")

            # Update last restart time and activate cooldown
            last_restart_time = time.time()
            print(
                f"  ✓ Restart action completed (cooldown active for {COOLDOWN_PERIOD}s)\n"
            )

    except Exception as e:
        print(f"  ✗ Error during operation: {e}\n")


def main():
    print("=== qBittorrent Speed Monitor (Continuous) ===")
    print(f"Speed threshold: {SPEED_THRESHOLD / 1024:.2f} KiB/s")
    print(f"Check interval: {CHECK_INTERVAL} seconds")
    print(f"Cooldown period: {COOLDOWN_PERIOD} seconds")
    print("Press Ctrl+C to stop monitoring\n")

    # Connect to qBittorrent
    try:
        qbt_client = qbittorrentapi.Client(
            host=HOST, port=PORT, username=USERNAME, password=PASSWORD
        )
        qbt_client.auth_log_in()
        print(f"✓ Connected to qBittorrent {qbt_client.app.version}")
        print(f"✓ Web API version: {qbt_client.app.web_api_version}\n")
    except qbittorrentapi.LoginFailed as e:
        print(f"✗ Login failed: {e}")
        return
    except Exception as e:
        print(f"✗ Connection error: {e}")
        return

    # Continuous monitoring loop
    try:
        while True:
            check_and_restart_if_slow(qbt_client)
            time.sleep(CHECK_INTERVAL)

    except KeyboardInterrupt:
        print("\n\n✓ Monitoring stopped by user (Ctrl+C)")
    except Exception as e:
        print(f"\n✗ Unexpected error: {e}")
    finally:
        # Clean up and log out
        try:
            qbt_client.auth_log_out()
            print("✓ Disconnected from qBittorrent")
        except:
            pass


if __name__ == "__main__":
    main()
