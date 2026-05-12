#!/bin/bash
set -e

# =============================================
# Run Flutter app on iOS Simulator
# Usage: ./scripts/run_ios.sh [device_name]
# Default device: iPhone 16 Pro
# =============================================

DEVICE="${1:-iPhone 16 Pro}"
PROJECT_ROOT="$(cd "$(dirname "$0")/.." && pwd)"

GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

log_info()    { echo -e "${BLUE}[iOS]${NC} $1"; }
log_success() { echo -e "${GREEN}[iOS]${NC} $1"; }
log_warn()    { echo -e "${YELLOW}[iOS]${NC} $1"; }
log_error()   { echo -e "${RED}[iOS]${NC} $1"; }

cd "$PROJECT_ROOT"

log_info "Target device: $DEVICE"

# Find the UDID of the requested simulator
UDID=$(xcrun simctl list devices available --json | python3 -c "
import json, sys
data = json.load(sys.stdin)
name = sys.argv[1]
for devs in data['devices'].values():
    for d in devs:
        if d['name'] == name and d['isAvailable']:
            print(d['udid'])
            exit()
" "$DEVICE" 2>/dev/null)

if [ -z "$UDID" ]; then
  log_error "Simulator '$DEVICE' not found."
  log_warn "Available simulators:"
  xcrun simctl list devices available | grep "iPhone\|iPad" | head -15
  exit 1
fi

log_info "Booting simulator: $DEVICE ($UDID)"
xcrun simctl boot "$UDID" 2>/dev/null || true

log_info "Opening Simulator app..."
open -a Simulator

# Wait until simulator is fully booted
log_info "Waiting for simulator to be ready..."
until xcrun simctl list devices | grep "$UDID" | grep -q "Booted"; do
  sleep 1
done
log_success "Simulator is ready"

log_info "Getting dependencies..."
flutter pub get

log_success "Launching app on $DEVICE..."
flutter run -d "$UDID"
