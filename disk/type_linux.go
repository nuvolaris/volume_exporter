//go:build linux && !s390x && !arm && !386
// +build linux,!s390x,!arm,!386

package disk

import "strconv"

// fsType2StringMap - list of filesystems supported on linux
var fsType2StringMap = map[string]string{
	"1021994":  "TMPFS",
	"137d":     "EXT",
	"4244":     "HFS",
	"4d44":     "MSDOS",
	"52654973": "REISERFS",
	"5346544e": "NTFS",
	"58465342": "XFS",
	"61756673": "AUFS",
	"6969":     "NFS",
	"ef51":     "EXT2OLD",
	"ef53":     "EXT4",
	"f15f":     "ecryptfs",
	"794c7630": "overlayfs",
	"2fc12fc1": "zfs",
	"ff534d42": "cifs",
	"53464846": "wslfs",
}

// getFSType returns the filesystem type of the underlying mounted filesystem
func getFSType(ftype int64) string {
	fsTypeHex := strconv.FormatInt(ftype, 16)
	fsTypeString, ok := fsType2StringMap[fsTypeHex]
	if !ok {
		return "UNKNOWN"
	}
	return fsTypeString
}
