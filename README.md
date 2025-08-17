# homebrew-gnuradio

This is a modernized fork of the original [titanous/homebrew-gnuradio](https://github.com/titanous/homebrew-gnuradio) repository, updated to use current Homebrew syntax and standards with GNU Radio 3.10.12.0.

## About This Fork

This repository modernizes the original titanous/homebrew-gnuradio tap by:
- **Updated to GNU Radio 3.10.12.0** (latest stable release)
- **Modern Homebrew virtual environment support** using `Language::Python::Virtualenv`
- **Proper Python dependency management** with `resource` blocks
- **Updated all formulae** to use current Homebrew syntax
- **Added comprehensive configuration** for GNU Radio Companion (GRC)
- **Removed deprecated `Formula.factory` calls**
- **Added proper test methods** for all formulae
- **Maintaining compatibility** with existing GNU Radio installations

## Key Features

### 🐍 **Modern Python Environment**
- Uses Homebrew's `Language::Python::Virtualenv` for isolated Python dependencies
- Automatically installs all required Python packages with correct versions
- No conflicts with system Python or other Python environments
- Reproducible environment with exact package versions

### 🔧 **Automatic Configuration**
- Creates proper `~/.config/gnuradio/config.conf` configuration
- Sets correct block paths for GNU Radio Companion
- Configures virtual environment wrapper scripts
- Handles all environment variables automatically

### 📦 **Comprehensive Dependencies**
- All required C/C++ libraries (codec2, libgsm, gmp, etc.)
- All Python dependencies (numpy < 2.0, scipy, matplotlib, qtpy, etc.)
- Proper Qt5 integration for GUI components
- SoapySDR and IIO support

## Available Formulae

### Core
- **gnuradio** - GNU Radio 3.10.12.0 (SDK for signal processing blocks)

### Modules
- **gr-lora_sdr** - LoRa (Long Range) communication module
- **gr-osmosdr** - OsmoSDR source blocks for various SDR devices
- **gr-baz** - GNU Radio blocks by Balint Seeber
- **rtlsdr** - RTL-SDR library and utilities

## System Requirements

This tap has been tested on:
- macOS Sonoma 14.6.1
- Homebrew 4.2.0+
- Python 3.13 (via Homebrew)

## Installation

### Prerequisites

Ensure you have Homebrew installed and updated:
```sh
brew update
```

### Install This Tap

```sh
brew tap mustacheride/gnuradio
```

### Install GNU Radio Core

```sh
brew install mustacheride/gnuradio/gnuradio
```

This will:
- Install GNU Radio 3.10.12.0 with all dependencies
- Create a virtual environment with all Python packages
- Set up proper configuration files
- Create wrapper scripts for easy access

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

## Usage

### Launching GNU Radio Companion

#### Method 1: Use the Wrapper Script (Recommended)
```sh
gnuradio-companion --qt
```

#### Method 2: Activate the Virtual Environment Manually
```sh
source /usr/local/libexec/gnuradio/venv/bin/activate
gnuradio-companion --qt
deactivate
```

#### Method 3: Run Directly in the Virtual Environment
```sh
/usr/local/libexec/gnuradio/venv/bin/python -m gnuradio.grc --qt
```

### Python Scripts

For running Python scripts that use GNU Radio:

```sh
# Method 1: Use the wrapper
gnuradio-companion your_script.py

# Method 2: Use the virtual environment directly
/usr/local/libexec/gnuradio/venv/bin/python your_script.py

# Method 3: Activate the environment
source /usr/local/libexec/gnuradio/venv/bin/activate
python your_script.py
deactivate
```

## Configuration

### Automatic Configuration

The formula automatically creates:
- `~/.config/gnuradio/config.conf` - Main configuration
- `~/.config/gnuradio/grc.conf` - GUI settings
- Virtual environment at `/usr/local/libexec/gnuradio/venv/`
- Wrapper scripts in `/usr/local/bin/`

### Manual Configuration (if needed)

If you need to customize the configuration, edit:
```sh
nano ~/.config/gnuradio/config.conf
```

Key settings:
```ini
[grc]
local_blocks_path=/usr/local/share/gnuradio/grc/blocks
global_blocks_path=/usr/local/share/gnuradio/grc/blocks
default_flow_graph=
```

## Testing

After installation, verify everything works:

```sh
# Test Python bindings
/usr/local/libexec/gnuradio/venv/bin/python -c "import gnuradio; print('GNU Radio imported successfully')"

# Test GNU Radio Companion
gnuradio-companion --qt --help

# Test individual modules (if installed)
/usr/local/libexec/gnuradio/venv/bin/python -c "import gnuradio.lora_sdr; print('gr-lora_sdr imported successfully')"
/usr/local/libexec/gnuradio/venv/bin/python -c "import gnuradio.osmosdr; print('gr-osmosdr imported successfully')"
```

## Virtual Environment Details

### Location
- **Virtual Environment**: `/usr/local/libexec/gnuradio/venv/`
- **Python Executable**: `/usr/local/libexec/gnuradio/venv/bin/python`
- **Pip**: `/usr/local/libexec/gnuradio/venv/bin/pip`

### Included Packages
- numpy (1.26.4) - Scientific computing
- scipy (1.16.1) - Scientific computing
- matplotlib (3.10.5) - Plotting
- qtpy (2.4.1) - Qt bindings
- mako (1.3.9) - Template engine
- pyyaml (6.0.2) - YAML parser
- click (8.1.8) - Command line interface
- six (1.16.0) - Python 2/3 compatibility
- lxml (5.3.1) - XML processing
- requests (2.32.4) - HTTP library
- packaging (24.2) - Package utilities

### Environment Variables
The wrapper scripts automatically set:
- `PYTHONPATH` - Points to GNU Radio Python modules
- `GR_PREFIX` - Points to GNU Radio installation
- `VIRTUAL_ENV` - Points to the virtual environment
- `PATH` - Includes virtual environment binaries

## Troubleshooting

### Common Issues

#### "No module named 'gnuradio'"
```sh
# Ensure you're using the virtual environment
source /usr/local/libexec/gnuradio/venv/bin/activate
python -c "import gnuradio"
```

#### "Failed to find built-in GRC blocks"
```sh
# Check configuration file exists
ls -la ~/.config/gnuradio/config.conf

# Recreate if missing
brew reinstall mustacheride/gnuradio/gnuradio
```

#### "numpy version incompatibility"
The virtual environment automatically installs numpy < 2.0. If you see this error, ensure you're using the virtual environment:
```sh
/usr/local/libexec/gnuradio/venv/bin/python -c "import numpy; print(numpy.__version__)"
```

### Reinstalling

To completely reinstall GNU Radio:
```sh
brew uninstall gnuradio
brew install mustacheride/gnuradio/gnuradio
```

## Development

### Building from Source

To build the formula from source:
```sh
cd /path/to/homebrew-gnuradio
brew install --build-from-source ./gnuradio.rb
```

### Testing the Formula

```sh
# Test syntax
ruby -c gnuradio.rb

# Test installation (dry run)
brew install --dry-run ./gnuradio.rb
```

## Notes

- **GNU Radio Version**: Updated to 3.10.12.0 (latest stable)
- **Python Version**: Uses Python 3.13 via Homebrew
- **Virtual Environment**: Isolated Python environment prevents conflicts
- **Configuration**: Modern `~/.config/gnuradio/` location
- **Dependencies**: All managed via Homebrew's resource system
- **Compatibility**: Works with existing GNU Radio installations

## Original Repository

This is a fork of [titanous/homebrew-gnuradio](https://github.com/titanous/homebrew-gnuradio). The original repository provided the foundation for GNU Radio on macOS via Homebrew.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
