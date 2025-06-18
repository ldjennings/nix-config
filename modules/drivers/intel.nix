{pkgs, ...}: {
  # hardware.graphics = {
  #   extraPackages = with pkgs; [
  #     intel-media-driver
  #     vaapiIntel
  #     vaapiVdpau
  #     libvdpau-va-gl
  #   ];
  # };
  nixpkgs.config.packageOverrides = pkgs: {
    vaapiIntel = pkgs.vaapiIntel.override {enableHybridCodec = true;};
  };
  #   hardware.opengl = {
  #     enable = true;
  #     extraPackages = with pkgs; [
  #       intel-media-driver
  #       vaapiIntel
  #       vaapiVdpau
  #       libvdpau-va-gl
  #       intel-compute-runtime
  #       vpl-gpu-rt
  #       intel-media-sdk
  #     ];
  #   };

  hardware.graphics = {
    enable = true;
    # driSupport = true;
    enable32Bit = true; # Needed if you use Steam, Wine, etc.

    extraPackages = with pkgs; [
      mesa # includes Vulkan & OpenGL drivers
      vulkan-loader # core Vulkan runtime
      vulkan-validation-layers # dev/test layers
      vulkan-tools # includes `vulkaninfo`
      intel-media-driver # preferred VAAPI driver for Gen9+
      vaapiVdpau
      libvdpau-va-gl
      intel-compute-runtime # OpenCL support
      intel-media-sdk # QSV (Gen11 and earlier)
    ];
  };
}
