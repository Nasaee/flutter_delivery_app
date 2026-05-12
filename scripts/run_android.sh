#!/bin/bash
set -e

# =============================================
# Run Flutter app on Android Emulator
# Usage: ./scripts/run_android.sh [emulator_id]
# Default emulator: Pixel_9_Pro
# =============================================

EMULATOR_ID="${1:-Pixel_9_Pro}"
PROJECT_ROOT="$(cd "$(dirname "$0")/.." && pwd)"

GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

log_info()    { echo -e "${BLUE}[Android]${NC} $1"; }
log_success() { echo -e "${GREEN}[Android]${NC} $1"; }
log_warn()    { echo -e "${YELLOW}[Android]${NC} $1"; }
log_error()   { echo -e "${RED}[Android]${NC} $1"; }

cd "$PROJECT_ROOT"

log_info "Target emulator: $EMULATOR_ID"

# Verify emulator exists
if ! flutter emulators 2>/dev/null | grep -q "$EMULATOR_ID"; then
  log_error "Emulator '$EMULATOR_ID' not found."
  log_warn "Available emulators:"
  flutter emulators 2>/dev/null | grep "^[A-Za-z]"
  exit 1
fi

# Check if emulator is already running
RUNNING=$(adb devices 2>/dev/null | grep "emulator" | grep "device$" | awk '{print $1}' | head -1)

if [ -z "$RUNNING" ]; then
  log_info "Starting emulator: $EMULATOR_ID"
  flutter emulators --launch "$EMULATOR_ID"

  log_info "Waiting for emulator to be ready..."
  until adb shell getprop sys.boot_completed 2>/dev/null | grep -q "1"; do
    sleep 2
  done
  log_success "Emulator is ready"
else
  log_success "Emulator already running: $RUNNING"
fi

log_info "Getting dependencies..."
flutter pub get

log_success "Launching app on $EMULATOR_ID..."
flutter run -d "$EMULATOR_ID"
