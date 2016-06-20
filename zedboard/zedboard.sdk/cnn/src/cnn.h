#define FWID    5
#define FHEI    5
#define IMWID   28
#define IMHEI   28
#define PWID    2
#define PHEI    2
#define N_F1    20
#define N_F2    50
#define N_HL    500
#define LABEL   10

#define CORE    8
#define DWIDTH  16
#define LWIDTH  8
#define INSIZE  12
#define FSIZE   5
#define PSIZE   2
#define OUTSIZE 10
#define WSIZE   13
#define IFMSIZE 9
#define FACCUM  7
#define PACCUM  8

#define FM1HEI (IMHEI-FHEI+1)
#define FM1WID (IMWID-FWID+1)
#define PM1HEI FM1HEI/PHEI
#define PM1WID FM1WID/PWID
#define FM2HEI (PM1HEI-FHEI+1)
#define FM2WID (PM1WID-FWID+1)
#define PM2HEI FM2HEI/PHEI
#define PM2WID FM2WID/PWID

#include "xparameters.h"
#include "myip.h"

const int reg_req       = XPAR_MYIP_0_S_AXI_BASEADDR + MYIP_S_AXI_SLV_REG0_OFFSET;
const int reg_enable    = XPAR_MYIP_0_S_AXI_BASEADDR + MYIP_S_AXI_SLV_REG1_OFFSET;
const int reg_param     = XPAR_MYIP_0_S_AXI_BASEADDR + MYIP_S_AXI_SLV_REG2_OFFSET;
const int reg_input     = XPAR_MYIP_0_S_AXI_BASEADDR + MYIP_S_AXI_SLV_REG3_OFFSET;
const int reg_weight    = XPAR_MYIP_0_S_AXI_BASEADDR + MYIP_S_AXI_SLV_REG4_OFFSET;
const int reg_out_addr  = XPAR_MYIP_0_S_AXI_BASEADDR + MYIP_S_AXI_SLV_REG5_OFFSET;
const int reg_out_val   = XPAR_MYIP_0_S_AXI_BASEADDR + MYIP_S_AXI_SLV_REG6_OFFSET;
const int reg_ack       = XPAR_MYIP_0_S_AXI_BASEADDR + MYIP_S_AXI_SLV_REG7_OFFSET;
