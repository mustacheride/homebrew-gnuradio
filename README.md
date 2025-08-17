# homebrew-gnuradio

This is a modernized fork of the original [titanous/homebrew-gnuradio](https://github.com/titanous/homebrew-gnuradio) repository, updated to use current Homebrew syntax and standards.

## About This Fork

This repository modernizes the original titanous/homebrew-gnuradio tap by:
- Updating all formulae to use current Homebrew syntax
- Adding the new `gr-lora_sdr` formula for LoRa communication
- Removing deprecated `Formula.factory` calls
- Adding proper test methods for all formulae
- Maintaining compatibility with existing GNU Radio installations

## Available Formulae

### Core
- **gnuradio** - GNU Radio 3.6.5.1 (SDK for signal processing blocks)

### Modules
- **gr-lora_sdr** - LoRa (Long Range) communication module (NEW)
- **gr-osmosdr** - OsmoSDR source blocks for various SDR devices
- **gr-baz** - GNU Radio blocks by Balint Seeber
- **rtlsdr** - RTL-SDR library and utilities

## System Requirements

This tap has been tested on:
- macOS Sonoma 14.6.1
- Homebrew 4.2.0
- Python 3.13 (via Homebrew)
- GNU Radio 3.10.12.0 (existing installation)

## Installation

### Prerequisites

Ensure you have Homebrew installed and updated:
```sh
brew update
```

### Install GNU Radio Core

The formulae in this tap are designed to work with existing GNU Radio installations. If you don't have GNU Radio installed:

```sh
brew install gnuradio
```

### Install This Tap

```sh
brew tap mustacheride/gnuradio
```

### Install Additional Modules

Most GNU Radio modules are HEAD-only formulae and require the `--HEAD` flag:

```sh
# Install LoRa support
brew install --HEAD mustacheride/gnuradio/gr-lora_sdr

# Install RTL-SDR support
brew install mustacheride/gnuradio/rtlsdr
brew install --HEAD mustacheride/gnuradio/gr-osmosdr
brew install --HEAD mustacheride/gnuradio/gr-baz
```

### Configuration

Create the `~/.gnuradio/config.conf` config file for custom block support:

```ini
[grc]
local_blocks_path=/usr/local/share/gnuradio/grc/blocks
```

## Usage Examples

Install GNU Radio with LoRa support:
```sh
brew tap mustacheride/gnuradio
brew install --HEAD mustacheride/gnuradio/gr-lora_sdr
```

Install complete RTL-SDR setup:
```sh
brew tap mustacheride/gnuradio
brew install mustacheride/gnuradio/rtlsdr
brew install --HEAD mustacheride/gnuradio/gr-osmosdr
brew install --HEAD mustacheride/gnuradio/gr-baz
```

## Testing

After installation, verify the modules work:

```sh
# Test gr-lora_sdr
/usr/local/bin/python3 -c "import gnuradio.lora_sdr; print('gr-lora_sdr imported successfully')"

# Test gr-osmosdr
/usr/local/bin/python3 -c "import gnuradio.osmosdr; print('gr-osmosdr imported successfully')"
```

## Notes

- This fork maintains the original GNU Radio 3.6.5.1 formula for compatibility
- All formulae have been updated to use modern Homebrew syntax
- Python modules are installed to the Homebrew Python environment
- The `gr-lora_sdr` formula is new to this fork and not available in the original repository
- Formulae are designed to work with existing GNU Radio 3.10+ installations
- All formulae include proper test methods

## Original Repository

This is a fork of [titanous/homebrew-gnuradio](https://github.com/titanous/homebrew-gnuradio). The original repository provided the foundation for GNU Radio on macOS via Homebrew.
