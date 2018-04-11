// ****************************************************************************
// NOTE:  by Hiwen
//  1. Function: 
//  === Read Slave Device (like SPD) information through SMBus ===
//
//  2. SMB_BASE  and  SlaveAddress is changed on each MB, 
//      So please read PCH Spec and ask EE Engineer
//
//  3. Desktop(Orange-S) DIMM & SPD:
//      MB from outside to inside: DIMM1~> 2 -> 3 -> DIMM4
//      SPD(Slave Adress):         A6 -> A4 -> A2 -> A0
// 
//  4. In the programa: 
//      SMB_BASE & SlaveAddress is fixed value
//***************************************************************************

#include "stdio.h"
#include "dos.h"
#include "conio.h"
#include "string.h"

//**************************************
//  SMBus Base Address (SMB_BASE) 
//  Slave Address
//**************************************
// My notebook(Lenovo)
#define SMB_BASE 0x1C00
#define SlaveAddress 0xA0

//Desktop (Orange-S )
//#define SMB_BASE 0xF040
//#define SlaveAddress 0xA6


//*******************************************************
//  SMBus I/O and Menmory Mapped I/O Registers
//******************************************************8
unsigned short HST_STS = SMB_BASE +0x00;
unsigned short HST_CNT = SMB_BASE +0x02;
unsigned short HST_CMD = SMB_BASE +0x03;
unsigned short XMIT_SLVA = SMB_BASE +0x04;
unsigned short HST_D0 = SMB_BASE +0x05;
unsigned short HOST_BLOCK_DB = SMB_BASE +0x07;

//*****************
//  Read by byte
//*****************
int Byte(int offset)
{  
	//HST_STS = 40H ?
	printf(" [Before Clear] HST_STS(00h): %#x\n",inp(HST_STS));
	if( inp(HST_STS)&0x40 == 0x40)
	{
		outp(HST_STS,0xff);
	}
	outp(HST_STS,0xff);  //After first read by block, HST_STS will C2h, so command it, too
	printf(" [After Clear] HST_STS(00h): %#x\n",inp(HST_STS));
	
	//Slave Address(SPD)
	outp(XMIT_SLVA,SlaveAddress+0x01);  
	printf("XMIT_SLVA(04h:Slave Address) is: %#x\n",inp(XMIT_SLVA));
	
	//Slave Device(SPD) offset
	outp(HST_CMD,offset);  
	printf("HST_CMD(03h:SPD offset) is: %#x\n",inp(HST_CMD));
	
	//Command (48h: Read by byte)
	outp(HST_CNT,0X48); 
	printf("After Commad(48) HST_CNT(02h) is: %#x\n",inp(HST_CNT));
	
	//Result
	printf("\nResult:\n=== SPD Data(0ffset=%#x) is: %#x ===\n",offset,inp(HST_D0));
	
	//Clear status
	outp(HST_STS,0xff);  
	
	return 0;
}


//******************
//   Read By Block
//******************
int Block(int offset,int count)
{
	int i,j;
	int real_count;
	unsigned short block[255];
	
	//HST_STS = 40H ?
	printf(" [Before Clear] HST_STS(00h): %#x\n",inp(HST_STS));
	if( inp(HST_STS)&0x40 == 0x40)
	{
		outp(HST_STS,0xff);
	}
	outp(HST_STS,0xff); //After first read by block, HST_STS will C2h, so command it, too
	printf(" [After Clear] HST_STS(00h): %#x\n",inp(HST_STS));
	
	// Input count (want to read count)
	outp(HST_D0,count); 
	printf("The HST_D0(05h) is: %#x\n",inp(HST_D0)); 
	
	//Slave Address (like SPD)
	outp(XMIT_SLVA,SlaveAddress+0x01);  
	printf("XMIT_SLVA(04h:Slave Address) is: %#x\n",inp(XMIT_SLVA));
	
	//Slave Device(SPD) offset  
	outp(HST_CMD,offset); 
	printf("HST_CMD(03h:SPD offset) is: %#x\n",inp(HST_CMD));
	
	//Command (54h: Read by block)
	outp(HST_CNT,0X54);  
	printf("After Commad(54h) HST_STS(00h): %#x\n",inp(HST_STS));
	printf("After Commad(54h) HST_CNT(02h) is: %#x\n",inp(HST_CNT));
	
	printf("\n=== Can read real Count (HST_D0) is %#x ===\n",inp(HST_D0));
	real_count = inp(HST_D0)&0x00FF;
	
	block[0] = inp(HST_D0);
	block[1] = inp(HOST_BLOCK_DB);
	
	if(real_count < count)
		count = real_count;
	
	printf("\n===So the real count is %d ===\n",count );
	
	for(i=2; i<count; i++)
	{
		outp(HST_STS,0xff); 
		j=0;
		while(j<500) 
		{
			// printf(" [while] HST_STS(00h): %#x\n",inp(HST_STS));
			if( inp(HST_STS) == 0xC1 )
			{
				//printf(" [if] HST_STS(00h): %#x\n",inp(HST_STS));
				block[i] = inp(HOST_BLOCK_DB);
				break;
			}
			else
				j++;
		}// (While) After clear, waiting the value of HST_STS change to C1h
	}
	
	//Clear status 
	for(i=0;i<255;i++)
	{
		j=500;
		while(j)
		{
			j--;
		}// While: Delay
		outp(HST_STS,0xff); 
	}
	printf(" [End] HST_STS(00h): %#x\n",inp(HST_STS));
	
	//Dispaly the block data
	printf("\nResult:\n=== block data [real count=%d] ===\n",count);
	for(i=0; i<count; i++)
	{
		printf("%#x  ",block[i]&0x00FF);
	}
	
	return 0;
}


int main()
{
	char choice;
    int offset;
    int count;
	
	printf("===== SMBus Base Address = %#x =====\n",SMB_BASE);
	printf("=== Read Slave Device (like SPD) information through SMBus ===\n");
    
    printf("1: Byte Read !\n");
    printf("2: Block Read !\n\n");
  
    printf("Please input the choice :");
    scanf("%c",&choice);
  
    if(choice == '1')
	{
		printf("\n=== Read Byte ===\n");
		printf("Please input Slave_Device offset(00h~FFh)[such as, 0A,1F...]: ");
		scanf("%x",&offset);
		Byte(offset);
	}
	else if(choice == '2')
	{
		printf("\n=== Block Byte ===\n");
		printf("Please input offset(00h~FFh) and count(2~18): "); //count: use RW read by block, offset=00h(92h), it can only read to offset=12h(69h)
		scanf("%x%d",&offset,&count);
		Block(offset,count);
	}
	else
		printf("Input error!\n");
	
	return 0;
}


