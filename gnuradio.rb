class Gnuradio < Formula
  include Language::Python::Virtualenv

  desc "Software development toolkit that provides signal processing blocks to implement software radios"
  homepage "https://www.gnuradio.org/"
  url "https://github.com/gnuradio/gnuradio/archive/v3.10.12.0.tar.gz"
  sha256 "fe78ad9f74c8ebf93d5c8ad6fa2c13236af330f3c67149d91a0647b3dc6f3958"
  license "GPL-3.0-or-later"
  head "https://github.com/gnuradio/gnuradio.git", branch: "main"

  depends_on "cmake" => :build
  depends_on "pkg-config" => :build
  depends_on "python@3.13" => :build
  depends_on "boost"
  depends_on "cppunit"
  depends_on "fftw"
  depends_on "gsl"
  depends_on "libusb"
  depends_on "log4cpp"
  depends_on "orc"
  depends_on "pybind11"
  depends_on "qt@5"
  depends_on "pyqt@5"
  depends_on "qwt-qt5"
  depends_on "sdl"
  depends_on "spdlog"
  depends_on "swig"
  depends_on "uhd"
  depends_on "volk"
  depends_on "zeromq"
  depends_on "soapysdr"
  depends_on "gmp"
  depends_on "codec2"
  depends_on "libgsm"

  # Python dependencies as resources
  resource "numpy" do
    url "https://files.pythonhosted.org/packages/65/6e/09db70a523a96d25e115e71cc56a6f9031e7b8cd166c1ac8438307c14058/numpy-1.26.4.tar.gz"
    sha256 "2a02aba9ed12e4ac4eb3ea9421c420301a0c6460d9830d74a9df87efa4912010"
  end

  resource "scipy" do
    url "https://files.pythonhosted.org/packages/f5/4a/b927028464795439faec8eaf0b03b011005c487bb2d07409f28bf30879c4/scipy-1.16.1.tar.gz"
    sha256 "44c76f9e8b6e8e488a586190ab38016e4ed2f8a038af7cd3defa903c0a2238b3"
  end

  resource "matplotlib" do
    url "https://files.pythonhosted.org/packages/43/91/f2939bb60b7ebf12478b030e0d7f340247390f402b3b189616aad790c366/matplotlib-3.10.5.tar.gz"
    sha256 "352ed6ccfb7998a00881692f38b4ca083c691d3e275b4145423704c34c909076"
  end

  resource "qtpy" do
    url "https://files.pythonhosted.org/packages/eb/9a/7ce646daefb2f85bf5b9c8ac461508b58fa5dcad6d40db476187fafd0148/QtPy-2.4.1.tar.gz"
    sha256 "a5a15ffd519550a1361bdc56ffc07fda56a6af7292f17c7b395d4083af632987"
  end

  resource "mako" do
    url "https://files.pythonhosted.org/packages/62/4f/ddb1965901bc388958db9f0c991255b2c469349a741ae8c9cd8a562d70a6/mako-1.3.9.tar.gz"
    sha256 "b5d65ff3462870feec922dbccf38f6efb44e5714d7b593a656be86663d8600ac"
  end

  resource "pyyaml" do
    url "https://files.pythonhosted.org/packages/54/ed/79a089b6be93607fa5cdaedf301d7dfb23af5f25c398d5ead2525b063e17/pyyaml-6.0.2.tar.gz"
    sha256 "d584d9ec91ad65861cc08d42e834324ef890a082e591037abe114850ff7bbc3e"
  end

  resource "click" do
    url "https://files.pythonhosted.org/packages/b9/2e/0090cbf739cee7d23781ad4b89a9894a41538e4fcf4c31dcdd705b78eb8b/click-8.1.8.tar.gz"
    sha256 "ed53c9d8990d83c2a27deae68e4ee337473f6330c040a31d4225c9574d16096a"
  end

  resource "six" do
    url "https://files.pythonhosted.org/packages/71/39/171f1c67cd00715f190ba0b100d606d440a28c93c7714febeca8b79af85e/six-1.16.0.tar.gz"
    sha256 "1e61c37477a1626458e36f7b1d82aa5c9b094fa4802892072e49de9c60c4c926"
  end

  resource "lxml" do
    url "https://files.pythonhosted.org/packages/ef/f6/c15ca8e5646e937c148e147244817672cf920b56ac0bf2cc1512ae674be8/lxml-5.3.1.tar.gz"
    sha256 "106b7b5d2977b339f1e97efe2778e2ab20e99994cbb0ec5e55771ed0795920c8"
  end

  resource "requests" do
    url "https://files.pythonhosted.org/packages/e1/0a/929373653770d8a0d7ea76c37de6e41f11eb07559b103b1c02cafb3f7cf8/requests-2.32.4.tar.gz"
    sha256 "27d0316682c8a29834d3264820024b62a36942083d52caf2f14c0591336d3422"
  end

  resource "packaging" do
    url "https://files.pythonhosted.org/packages/d0/63/68dbb6eb2de9cb10ee4c9c14a0148804425e13c4fb20d61cce69f53106da/packaging-24.2.tar.gz"
    sha256 "c228a6dc5e932d346bc5739379109d49e8853dd8223571c7c5b55260edc0b97f"
  end

  def python3
    "python3.13"
  end

  def install
    # Set up Python environment
    python = Formula["python@3.13"]
    python_version = Language::Python.major_minor_version(python.opt_bin/"python3")
    
    # Create virtual environment using Homebrew's standard approach
    site_packages = Language::Python.site_packages(python3)
    venv = virtualenv_create(libexec/"venv", python3)
    venv.pip_install resources
    ENV.prepend_create_path "PYTHONPATH", venv.root/site_packages
    
    # Set up environment variables
    ENV["PYTHONPATH"] = "#{lib}/python#{python_version}/site-packages"
    ENV["GR_PREFIX"] = prefix
    ENV["PKG_CONFIG_PATH"] = "#{Formula["qwt-qt5"].lib}/pkgconfig:#{Formula["qt@5"].lib}/pkgconfig"
    
    # Create build directory
    mkdir "build" do
      # Configure CMake with proper Qt5 and QWT settings
      args = std_cmake_args + %W[
        -DCMAKE_BUILD_TYPE=Release
        -DPYTHON_EXECUTABLE=#{venv.root}/bin/python
        -DPYTHON_INCLUDE_DIR=#{python.include}/python#{python_version}
        -DPYTHON_LIBRARY=#{python.lib}/libpython#{python_version}.dylib
        -DPYTHON_PACKAGES_PATH=#{lib}/python#{python_version}/site-packages
        -DENABLE_GR_QTGUI=ON
        -DENABLE_GR_WXGUI=OFF
        -DENABLE_GR_CTRLPORT=ON
        -DENABLE_GR_DTV=ON
        -DENABLE_GR_FEC=ON
        -DENABLE_GR_FILTER=ON
        -DENABLE_GR_ANALOG=ON
        -DENABLE_GR_DIGITAL=ON
        -DENABLE_GR_DSP=ON
        -DENABLE_GR_FFT=ON
        -DENABLE_GR_PDU=ON
        -DENABLE_GR_TRELLIS=ON
        -DENABLE_GR_UHD=ON
        -DENABLE_GR_UTILS=ON
        -DENABLE_GR_VOCODER=ON
        -DENABLE_GR_WAVELET=ON
        -DENABLE_GR_ZEROMQ=ON
        -DENABLE_VOLK=ON
        -DENABLE_VOLK_PROFILING=ON
        -DENABLE_GR_SOAPY=ON
        -DENABLE_GR_IIO=OFF
        -DENABLE_DOXYGEN=OFF
        -DENABLE_GRAPHVIZ=OFF
        -DCMAKE_PREFIX_PATH=#{prefix}
        -DQt5_DIR=#{Formula["qt@5"].lib}/cmake/Qt5
        -DQWT_INCLUDE_DIRS=#{Formula["qwt-qt5"].include}
        -DQWT_LIBRARIES=#{Formula["qwt-qt5"].lib}/qwt.framework
      ]

      # Build and install
      system "cmake", "..", *args
      system "make", "-j#{ENV.make_jobs}"
      system "make", "install"
    end

    # Create minimal configuration file
    (etc/"gnuradio").mkpath
    (etc/"gnuradio/config.conf").write <<~EOS
      [grc]
      local_blocks_path=#{share}/gnuradio/grc/blocks
      global_blocks_path=#{share}/gnuradio/grc/blocks
      default_flow_graph=
      xterm_executable=/usr/bin/open
      help_browser=default
      canvas_grid_size=8
      max_nouts=0
      max_message_size=16384
      performance_level=1
      generate_options=hb_lib
      output_language=python
      output_directory=.
      default_scheduler=TPB
      qss_theme=
      enable_hier_block_save=1
      show_ports=1
      show_block_ids=1
      show_block_comments=1
      show_block_parameters=1
      show_block_disabled=1
      show_block_cat=1
      show_block_type=1
      show_block_version=1
      show_block_doc=1
      show_block_license=1
      show_block_gui=1
      show_block_qtgui=1
      show_block_wxgui=1
      show_block_uhd=1
      show_block_osmosdr=1
      show_block_soapy=1
      show_block_audio=1
      show_block_video=1
      show_block_zeromq=1
      show_block_network=1
    EOS
  end

  def post_install
    # Create user configuration directory
    (Dir.home/".config/gnuradio").mkpath
    
    # Create user configuration file with correct block paths
    user_config = Dir.home/".config/gnuradio/config.conf"
    unless user_config.exist?
      user_config.write <<~EOS
        [grc]
        local_blocks_path=#{share}/gnuradio/grc/blocks
        global_blocks_path=#{share}/gnuradio/grc/blocks
        default_flow_graph=
        xterm_executable=/usr/bin/open
        help_browser=default
        canvas_grid_size=8
        max_nouts=0
        max_message_size=16384
        performance_level=1
        generate_options=hb_lib
        output_language=python
        output_directory=.
        default_scheduler=TPB
        qss_theme=
        enable_hier_block_save=1
        show_ports=1
        show_block_ids=1
        show_block_comments=1
        show_block_parameters=1
        show_block_disabled=1
        show_block_cat=1
        show_block_type=1
        show_block_version=1
        show_block_doc=1
        show_block_license=1
        show_block_gui=1
        show_block_qtgui=1
        show_block_wxgui=1
        show_block_uhd=1
        show_block_osmosdr=1
        show_block_soapy=1
        show_block_audio=1
        show_block_video=1
        show_block_zeromq=1
        show_block_network=1
      EOS
    end
    
    # Create wrapper script for gnuradio-companion to use virtual environment
    (bin/"gnuradio-companion").write <<~EOS
      #!/bin/bash
      export PYTHONPATH="#{lib}/python#{Formula["python@3.13"].version.major_minor}/site-packages:$PYTHONPATH"
      export GR_PREFIX="#{prefix}"
      export VIRTUAL_ENV="#{libexec}/venv"
      export PATH="#{libexec}/venv/bin:$PATH"
      exec "#{libexec}/venv/bin/python" -m gnuradio.grc "$@"
    EOS
    chmod 0755, bin/"gnuradio-companion"
  end

  test do
    # Test basic GNU Radio functionality
    system "#{bin}/gnuradio-config-info", "--version"
    
    # Test Python bindings using virtual environment
    system "#{libexec}/venv/bin/python", "-c", "import gnuradio; print('GNU Radio imported successfully')"
    
    # Test GNU Radio Companion with virtual environment
    system "#{libexec}/venv/bin/python", "-m", "gnuradio.grc", "--help"
    
    # Test UHD integration
    system "#{bin}/uhd_usrp_probe", "--version" if Formula["uhd"].installed?
    
    # Test VOLK
    system "#{bin}/volk_profile", "--version"
    
    # Test SoapySDR integration
    system "#{Formula["soapysdr"].bin}/SoapySDRUtil", "--info" if Formula["soapysdr"].installed?
  end

  def caveats
    <<~EOS
      GNU Radio has been installed with the following components:
      - Core signal processing blocks
      - Qt GUI (gnuradio-companion)
      - UHD support for USRP devices
      - VOLK vector optimization library
      - ZeroMQ messaging support
      - SoapySDR support

      Python dependencies are managed in a virtual environment at:
      #{libexec}/venv

      Configuration files have been installed to:
      - System config: #{etc}/gnuradio/config.conf
      - User config: ~/.config/gnuradio/config.conf

      To use custom blocks, add them to the local_blocks_path in your config file.

      Examples are available at: #{share}/gnuradio/examples

      Additional modules available in this tap:
      - gr-lora_sdr: LoRa communication support
      - gr-osmosdr: OsmoSDR source blocks
      - gr-baz: GNU Radio blocks by Balint Seeber
      - rtlsdr: RTL-SDR library and utilities

      To use GNU Radio Python bindings, you may need to set the PYTHONPATH:
      export PYTHONPATH="#{lib}/python#{Formula["python@3.13"].version.major_minor}/site-packages:$PYTHONPATH"
      
      GNU Radio requires numpy < 2.0. The formula automatically installs the correct version.
      
      To run GNU Radio Companion, simply use:
      gnuradio-companion
      
      To activate the virtual environment for development:
      source #{libexec}/venv/bin/activate
      
      Or run commands directly in the virtual environment:
      #{libexec}/venv/bin/python your_script.py
    EOS
  end
end
