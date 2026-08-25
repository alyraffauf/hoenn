_: {
  flake.nixosModules.pacifidlog = {
    boot = {
      resumeDevice = "/dev/mapper/cryptroot";
      kernelParams = ["resume_offset=2404082"];
    };

    systemd.sleep.settings.Sleep.HibernateMode = "shutdown";
  };
}
