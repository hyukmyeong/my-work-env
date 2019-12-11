#include "./linux/include/linux/module.h"
#include "./linux/include/linux/kprobes.h"
#include "./linux/include/linux/kallsyms.h"

struct kprobe kp;

int handler_pre(struct kprobe *p, struct pt_regs *regs)
{
       printk(KERN_INFO "pt_regs: %p, pid: %d, jiffies: %ld\n",
                     regs, current->tgid, jiffies);
       return 0;
}

static __init int init_kprobe_mikki(void)
{
#if 0
       /* set address to probe */
       kp.addr = (kprobe_opcode_t *)0x;
#else
       /* set variable to probe */
       kp.symbol_name = "mipi_dsi_on";
#endif
       kp.pre_handler = handler_pre;
       register_kprobe(&kp);
       return 0;
}

module_init(init_kprobe_mikki);

static __exit void cleanup_kprobe_mikki(void)
{
       unregister_kprobe(&kp);
}

module_exit(cleanup_kprobe_mikki);
MODULE_LICENSE("GPL");
