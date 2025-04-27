#include <linux/reboot.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/reboot.h>
#include <unistd.h>

int main() {
  setuid(0);
  int grub_result = system("grub-reboot 2");
  if (grub_result != 0) {
    fprintf(stderr, "Failed to set GRUB boot entry\n");
    return 1;
  }
  sync();
  reboot(LINUX_REBOOT_CMD_RESTART);
}
