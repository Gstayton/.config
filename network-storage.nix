{
  config,
  lib,
  pkgs,
  ...
}:

{
  fileSystems."/mnt/Tokyo" = {
    device = "//tokyo/storage/";
    options = [
	  "uid=kosan"
	  "gid=users"
    ];
  };
}
