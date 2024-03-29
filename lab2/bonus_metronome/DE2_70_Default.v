// --------------------------------------------------------------------
// Copyright (c) 2007 by Terasic Technologies Inc. 
// --------------------------------------------------------------------
//
// Permission:
//
//   Terasic grants permission to use and modify this code for use
//   in synthesis for all Terasic Development Boards and Altera Development 
//   Kits made by Terasic.  Other use of this code, including the selling 
//   ,duplication, or modification of any portion is strictly prohibited.
//
// Disclaimer:
//
//   This VHDL/Verilog or C/C++ source code is intended as a design reference
//   which illustrates how these types of functions can be implemented.
//   It is the user's responsibility to verify their design for
//   consistency and functionality through the use of formal
//   verification methods.  Terasic provides no warranty regarding the use 
//   or functionality of this code.
//
// --------------------------------------------------------------------
//           
//                     Terasic Technologies Inc
//                     356 Fu-Shin E. Rd Sec. 1. JhuBei City,
//                     HsinChu County, Taiwan
//                     302
//
//                     web: http://www.terasic.com/
//                     email: support@terasic.com
//
// --------------------------------------------------------------------
//
// Major Functions:	DE2_70_Default
//
// --------------------------------------------------------------------
//
// Revision History :
// --------------------------------------------------------------------
//   Ver  :| Author            :| Mod. Date :| Changes Made:
//   V1.0 :| Johnny FAN        :| 07/07/09  :| Initial Revision
// --------------------------------------------------------------------

module DE2_70_Default
	(
        ////////////////////    Mine Params     ////////////////////
        beat_i,
        inc_i,
        dec_i,
		switch_led_o,
    	bpm_ss1_o,
    	bpm_ss2_o,
    	bpm_ss3_o,
    	beat_o,
		hex_trash_i,
		////////////////////	Clock Input	 	////////////////////	 
		iCLK_28,						//  28.63636 MHz
		iCLK_50,						//	50 MHz
		iCLK_50_2,						//	50 MHz
		iCLK_50_3,						//	50 MHz
		iCLK_50_4,						//	50 MHz
		iEXT_CLOCK,						//	External Clock
		////////////////////	Push Button		////////////////////

		////////////////////	DPDT Switch		////////////////////
		iSW,							//	Toggle Switch[17:0]
		////////////////////	7-SEG Dispaly	////////////////////

		////////////////////////	LED		////////////////////////

		////////////////////////	UART	////////////////////////
		oUART_TXD,						//	UART Transmitter
		iUART_RXD,						//	UART Receiver
		oUART_CTS,          			//	UART Clear To Send
		iUART_RTS,          			//	UART Requst To Send
		////////////////////////	IRDA	////////////////////////
		oIRDA_TXD,						//	IRDA Transmitter
		iIRDA_RXD,						//	IRDA Receiver
		/////////////////////	SDRAM Interface		////////////////
		DRAM_DQ,						//	SDRAM Data bus 32 Bits
		oDRAM0_A,						//	SDRAM0 Address bus 13 Bits
		oDRAM1_A,						//	SDRAM1 Address bus 13 Bits
		oDRAM0_LDQM0,					//	SDRAM0 Low-byte Data Mask 
		oDRAM1_LDQM0,					//	SDRAM1 Low-byte Data Mask 
		oDRAM0_UDQM1,					//	SDRAM0 High-byte Data Mask
		oDRAM1_UDQM1,					//	SDRAM1 High-byte Data Mask
		oDRAM0_WE_N,					//	SDRAM0 Write Enable
		oDRAM1_WE_N,					//	SDRAM1 Write Enable
		oDRAM0_CAS_N,					//	SDRAM0 Column Address Strobe
		oDRAM1_CAS_N,					//	SDRAM1 Column Address Strobe
		oDRAM0_RAS_N,					//	SDRAM0 Row Address Strobe
		oDRAM1_RAS_N,					//	SDRAM1 Row Address Strobe
		oDRAM0_CS_N,					//	SDRAM0 Chip Select
		oDRAM1_CS_N,					//	SDRAM1 Chip Select
		oDRAM0_BA,						//	SDRAM0 Bank Address
		oDRAM1_BA,	 					//	SDRAM1 Bank Address
		oDRAM0_CLK,						//	SDRAM0 Clock
		oDRAM1_CLK,						//	SDRAM1 Clock
		oDRAM0_CKE,						//	SDRAM0 Clock Enable
		oDRAM1_CKE,						//	SDRAM1 Clock Enable
		////////////////////	Flash Interface		////////////////
		FLASH_DQ,						//	FLASH Data bus 15 Bits (0 to 14)
		FLASH_DQ15_AM1,					//  FLASH Data bus Bit 15 or Address A-1
		oFLASH_A,						//	FLASH Address bus 26 Bits
		oFLASH_WE_N,					//	FLASH Write Enable
		oFLASH_RST_N,					//	FLASH Reset
		oFLASH_WP_N,					//	FLASH Write Protect /Programming Acceleration 
		iFLASH_RY_N,					//	FLASH Ready/Busy output 
		oFLASH_BYTE_N,					//	FLASH Byte/Word Mode Configuration
		oFLASH_OE_N,					//	FLASH Output Enable
		oFLASH_CE_N,					//	FLASH Chip Enable
		////////////////////	SRAM Interface		////////////////
		SRAM_DQ,						//	SRAM Data Bus 32 Bits
		SRAM_DPA, 						//  SRAM Parity Data Bus
		oSRAM_A,						//	SRAM Address bus 22 Bits
		oSRAM_ADSC_N,       			//	SRAM Controller Address Status 	
		oSRAM_ADSP_N,                   //	SRAM Processor Address Status
		oSRAM_ADV_N,                    //	SRAM Burst Address Advance
		oSRAM_BE_N,                     //	SRAM Byte Write Enable
		oSRAM_CE1_N,        			//	SRAM Chip Enable
		oSRAM_CE2,          			//	SRAM Chip Enable
		oSRAM_CE3_N,        			//	SRAM Chip Enable
		oSRAM_CLK,                      //	SRAM Clock
		oSRAM_GW_N,         			//  SRAM Global Write Enable
		oSRAM_OE_N,         			//	SRAM Output Enable
		oSRAM_WE_N,         			//	SRAM Write Enable
		////////////////////	ISP1362 Interface	////////////////
		OTG_D,							//	ISP1362 Data bus 16 Bits
		oOTG_A,							//	ISP1362 Address 2 Bits
		oOTG_CS_N,						//	ISP1362 Chip Select
		oOTG_OE_N,						//	ISP1362 Read
		oOTG_WE_N,						//	ISP1362 Write
		oOTG_RESET_N,					//	ISP1362 Reset
		OTG_FSPEED,						//	USB Full Speed,	0 = Enable, Z = Disable
		OTG_LSPEED,						//	USB Low Speed, 	0 = Enable, Z = Disable
		iOTG_INT0,						//	ISP1362 Interrupt 0
		iOTG_INT1,						//	ISP1362 Interrupt 1
		iOTG_DREQ0,						//	ISP1362 DMA Request 0
		iOTG_DREQ1,						//	ISP1362 DMA Request 1
		oOTG_DACK0_N,					//	ISP1362 DMA Acknowledge 0
		oOTG_DACK1_N,					//	ISP1362 DMA Acknowledge 1
		////////////////////	LCD Module 16X2		////////////////

		////////////////////	SD_Card Interface	////////////////
		SD_DAT,							//	SD Card Data
		SD_DAT3,						//	SD Card Data 3
		SD_CMD,							//	SD Card Command Signal
		oSD_CLK,						//	SD Card Clock
		////////////////////	I2C		////////////////////////////
		I2C_SDAT,						//	I2C Data
		oI2C_SCLK,						//	I2C Clock
		////////////////////	PS2		////////////////////////////
		PS2_KBDAT,						//	PS2 Keyboard Data
		PS2_KBCLK,						//	PS2 Keyboard Clock		
		PS2_MSDAT,						//	PS2 Mouse Data
		PS2_MSCLK,						//	PS2 Mouse Clock
		////////////////////	VGA		////////////////////////////
		oVGA_CLOCK,   					//	VGA Clock
		oVGA_HS,						//	VGA H_SYNC
		oVGA_VS,						//	VGA V_SYNC
		oVGA_BLANK_N,					//	VGA BLANK
		oVGA_SYNC_N,					//	VGA SYNC
		oVGA_R,   						//	VGA Red[9:0]
		oVGA_G,	 						//	VGA Green[9:0]
		oVGA_B,  						//	VGA Blue[9:0]
		////////////	Ethernet Interface	////////////////////////
		ENET_D,						//	DM9000A DATA bus 16Bits
		oENET_CMD,						//	DM9000A Command/Data Select, 0 = Command, 1 = Data
		oENET_CS_N,						//	DM9000A Chip Select
		oENET_IOW_N,					//	DM9000A Write
		oENET_IOR_N,					//	DM9000A Read
		oENET_RESET_N,					//	DM9000A Reset
		iENET_INT,						//	DM9000A Interrupt
		oENET_CLK,						//	DM9000A Clock 25 MHz
		////////////////	Audio CODEC		////////////////////////
		AUD_ADCLRCK,					//	Audio CODEC ADC LR Clock
		iAUD_ADCDAT,					//	Audio CODEC ADC Data
		AUD_DACLRCK,					//	Audio CODEC DAC LR Clock
		oAUD_DACDAT,					//	Audio CODEC DAC Data
		AUD_BCLK,						//	Audio CODEC Bit-Stream Clock
		oAUD_XCK,						//	Audio CODEC Chip Clock
		////////////////	TV Decoder		////////////////////////
		iTD1_CLK27,						//	TV Decoder1 Line_Lock Output Clock 
		iTD1_D,    					    //	TV Decoder1 Data bus 8 bits
		iTD1_HS,						//	TV Decoder1 H_SYNC
		iTD1_VS,						//	TV Decoder1 V_SYNC
		oTD1_RESET_N,					//	TV Decoder1 Reset
		iTD2_CLK27,						//	TV Decoder2 Line_Lock Output Clock 		
		iTD2_D,    					    //	TV Decoder2 Data bus 8 bits
		iTD2_HS,						//	TV Decoder2 H_SYNC
		iTD2_VS,						//	TV Decoder2 V_SYNC
		oTD2_RESET_N,					//	TV Decoder2 Reset
		////////////////////	GPIO	////////////////////////////
		GPIO_0,							//	GPIO Connection 0 I/O
		GPIO_CLKIN_N0,     				//	GPIO Connection 0 Clock Input 0
		GPIO_CLKIN_P0,          		//	GPIO Connection 0 Clock Input 1
		GPIO_CLKOUT_N0,     			//	GPIO Connection 0 Clock Output 0
		GPIO_CLKOUT_P0,                 //	GPIO Connection 0 Clock Output 1
		GPIO_1,							//	GPIO Connection 1 I/O
		GPIO_CLKIN_N1,                  //	GPIO Connection 1 Clock Input 0
		GPIO_CLKIN_P1,                  //	GPIO Connection 1 Clock Input 1
		GPIO_CLKOUT_N1,                 //	GPIO Connection 1 Clock Output 0
		GPIO_CLKOUT_P1                  //	GPIO Connection 1 Clock Output 1
	   
	);

input [3:0] beat_i;

input [1:0] inc_i, dec_i; // 0:normal  1:fast

output [6:0] bpm_ss1_o, bpm_ss2_o, bpm_ss3_o;
output switch_led_o;
output reg [43:0] hex_trash_i;

output wire [3:0] beat_o;

integer cnt_btn, cnt_bpm, cnt_beat, freq, freq_beat, tmp1, tmp2; // unit = sec.

reg [9:0] bpm_o;
reg audio_o;

//===========================================================================
// PARAMETER declarations
//===========================================================================


//===========================================================================
// PORT declarations
//===========================================================================
////////////////////////	Clock Input	 	////////////////////////
input			iCLK_28;				//  28.63636 MHz
input			iCLK_50;				//	50 MHz
input			iCLK_50_2;				//	50 MHz
input           iCLK_50_3;				//	50 MHz
input           iCLK_50_4;				//	50 MHz
input           iEXT_CLOCK;				//	External Clock
////////////////////////	Push Button		////////////////////////

////////////////////////	DPDT Switch		////////////////////////
input	[17:0]	iSW;					//	Toggle Switch[17:0]
////////////////////////	7-SEG Dispaly	////////////////////////

////////////////////////////	LED		////////////////////////////

////////////////////////////	UART	////////////////////////////
output			oUART_TXD;				//	UART Transmitter
input			iUART_RXD;				//	UART Receiver
output			oUART_CTS;          	//	UART Clear To Send
input			iUART_RTS;          	//	UART Requst To Send
////////////////////////////	IRDA	////////////////////////////
output			oIRDA_TXD;				//	IRDA Transmitter
input			iIRDA_RXD;				//	IRDA Receiver
///////////////////////		SDRAM Interface	////////////////////////
inout	[31:0]	DRAM_DQ;				//	SDRAM Data bus 32 Bits
output	[12:0]	oDRAM0_A;				//	SDRAM0 Address bus 13 Bits
output	[12:0]	oDRAM1_A;				//	SDRAM1 Address bus 13 Bits
output			oDRAM0_LDQM0;			//	SDRAM0 Low-byte Data Mask 
output			oDRAM1_LDQM0;			//	SDRAM1 Low-byte Data Mask 
output			oDRAM0_UDQM1;			//	SDRAM0 High-byte Data Mask
output			oDRAM1_UDQM1;			//	SDRAM1 High-byte Data Mask
output			oDRAM0_WE_N;			//	SDRAM0 Write Enable
output			oDRAM1_WE_N;			//	SDRAM1 Write Enable
output			oDRAM0_CAS_N;			//	SDRAM0 Column Address Strobe
output			oDRAM1_CAS_N;			//	SDRAM1 Column Address Strobe
output			oDRAM0_RAS_N;			//	SDRAM0 Row Address Strobe
output			oDRAM1_RAS_N;			//	SDRAM1 Row Address Strobe
output			oDRAM0_CS_N;			//	SDRAM0 Chip Select
output			oDRAM1_CS_N;			//	SDRAM1 Chip Select
output	[1:0]	oDRAM0_BA;				//	SDRAM0 Bank Address
output	[1:0]	oDRAM1_BA;		 		//	SDRAM1 Bank Address
output			oDRAM0_CLK;				//	SDRAM0 Clock
output			oDRAM1_CLK;				//	SDRAM1 Clock
output			oDRAM0_CKE;				//	SDRAM0 Clock Enable
output			oDRAM1_CKE;				//	SDRAM1 Clock Enable
////////////////////////	Flash Interface	////////////////////////
inout	[14:0]	FLASH_DQ;				//	FLASH Data bus 15 Bits (0 to 14)
inout			FLASH_DQ15_AM1;			//  FLASH Data bus Bit 15 or Address A-1
output	[21:0]	oFLASH_A;				//	FLASH Address bus 22 Bits
output			oFLASH_WE_N;			//	FLASH Write Enable
output			oFLASH_RST_N;			//	FLASH Reset
output			oFLASH_WP_N;			//	FLASH Write Protect /Programming Acceleration 
input			iFLASH_RY_N;			//	FLASH Ready/Busy output 
output			oFLASH_BYTE_N;			//	FLASH Byte/Word Mode Configuration
output			oFLASH_OE_N;			//	FLASH Output Enable
output			oFLASH_CE_N;			//	FLASH Chip Enable
////////////////////////	SRAM Interface	////////////////////////
inout	[31:0]	SRAM_DQ;				//	SRAM Data Bus 32 Bits
inout	[3:0]	SRAM_DPA; 				//  SRAM Parity Data Bus
output	[18:0]	oSRAM_A;				//	SRAM Address bus 21 Bits
output			oSRAM_ADSC_N;       	//	SRAM Controller Address Status 	
output			oSRAM_ADSP_N;           //	SRAM Processor Address Status
output			oSRAM_ADV_N;            //	SRAM Burst Address Advance
output	[3:0]	oSRAM_BE_N;             //	SRAM Byte Write Enable
output			oSRAM_CE1_N;        	//	SRAM Chip Enable
output			oSRAM_CE2;          	//	SRAM Chip Enable
output			oSRAM_CE3_N;        	//	SRAM Chip Enable
output			oSRAM_CLK;              //	SRAM Clock
output			oSRAM_GW_N;         	//  SRAM Global Write Enable
output			oSRAM_OE_N;         	//	SRAM Output Enable
output			oSRAM_WE_N;         	//	SRAM Write Enable
////////////////////	ISP1362 Interface	////////////////////////
inout	[15:0]	OTG_D;					//	ISP1362 Data bus 16 Bits
output	[1:0]	oOTG_A;					//	ISP1362 Address 2 Bits
output			oOTG_CS_N;				//	ISP1362 Chip Select
output			oOTG_OE_N;				//	ISP1362 Read
output			oOTG_WE_N;				//	ISP1362 Write
output			oOTG_RESET_N;			//	ISP1362 Reset
inout			OTG_FSPEED;				//	USB Full Speed,	0 = Enable, Z = Disable
inout			OTG_LSPEED;				//	USB Low Speed, 	0 = Enable, Z = Disable
input			iOTG_INT0;				//	ISP1362 Interrupt 0
input			iOTG_INT1;				//	ISP1362 Interrupt 1
input			iOTG_DREQ0;				//	ISP1362 DMA Request 0
input			iOTG_DREQ1;				//	ISP1362 DMA Request 1
output			oOTG_DACK0_N;			//	ISP1362 DMA Acknowledge 0
output			oOTG_DACK1_N;			//	ISP1362 DMA Acknowledge 1
////////////////////	LCD Module 16X2	////////////////////////////

////////////////////	SD Card Interface	////////////////////////
inout			SD_DAT;					//	SD Card Data
inout			SD_DAT3;				//	SD Card Data 3
inout			SD_CMD;					//	SD Card Command Signal
output			oSD_CLK;				//	SD Card Clock
////////////////////////	I2C		////////////////////////////////
inout			I2C_SDAT;				//	I2C Data
output			oI2C_SCLK;				//	I2C Clock
////////////////////////	PS2		////////////////////////////////
inout		 	PS2_KBDAT;				//	PS2 Keyboard Data
inout			PS2_KBCLK;				//	PS2 Keyboard Clock
inout		 	PS2_MSDAT;				//	PS2 Mouse Data
inout			PS2_MSCLK;				//	PS2 Mouse Clock
////////////////////////	VGA			////////////////////////////
output			oVGA_CLOCK;   			//	VGA Clock
output			oVGA_HS;				//	VGA H_SYNC
output			oVGA_VS;				//	VGA V_SYNC
output			oVGA_BLANK_N;			//	VGA BLANK
output			oVGA_SYNC_N;			//	VGA SYNC
output	[9:0]	oVGA_R;   				//	VGA Red[9:0]
output	[9:0]	oVGA_G;	 				//	VGA Green[9:0]
output	[9:0]	oVGA_B;   				//	VGA Blue[9:0]
////////////////	Ethernet Interface	////////////////////////////
inout	[15:0]	ENET_D;					//	DM9000A DATA bus 16Bits
output			oENET_CMD;				//	DM9000A Command/Data Select, 0 = Command, 1 = Data
output			oENET_CS_N;				//	DM9000A Chip Select
output			oENET_IOW_N;			//	DM9000A Write
output			oENET_IOR_N;			//	DM9000A Read
output			oENET_RESET_N;			//	DM9000A Reset
input			iENET_INT;				//	DM9000A Interrupt
output			oENET_CLK;				//	DM9000A Clock 25 MHz
////////////////////	Audio CODEC		////////////////////////////
inout			AUD_ADCLRCK;			//	Audio CODEC ADC LR Clock
input			iAUD_ADCDAT;			//	Audio CODEC ADC Data
inout			AUD_DACLRCK;			//	Audio CODEC DAC LR Clock
output			oAUD_DACDAT;			//	Audio CODEC DAC Data
inout			AUD_BCLK;				//	Audio CODEC Bit-Stream Clock
output			oAUD_XCK;				//	Audio CODEC Chip Clock
////////////////////	TV Devoder		////////////////////////////
input			iTD1_CLK27;				//	TV Decoder1 Line_Lock Output Clock 
input	[7:0]	iTD1_D;    				//	TV Decoder1 Data bus 8 bits
input			iTD1_HS;				//	TV Decoder1 H_SYNC
input			iTD1_VS;				//	TV Decoder1 V_SYNC
output			oTD1_RESET_N;			//	TV Decoder1 Reset
input			iTD2_CLK27;				//	TV Decoder2 Line_Lock Output Clock 		
input	[7:0]	iTD2_D;    				//	TV Decoder2 Data bus 8 bits
input			iTD2_HS;				//	TV Decoder2 H_SYNC
input			iTD2_VS;				//	TV Decoder2 V_SYNC
output			oTD2_RESET_N;			//	TV Decoder2 Reset

////////////////////////	GPIO	////////////////////////////////
inout	[31:0]	GPIO_0;					//	GPIO Connection 0 I/O
input			GPIO_CLKIN_N0;     		//	GPIO Connection 0 Clock Input 0
input			GPIO_CLKIN_P0;          //	GPIO Connection 0 Clock Input 1
inout			GPIO_CLKOUT_N0;     	//	GPIO Connection 0 Clock Output 0
inout			GPIO_CLKOUT_P0;         //	GPIO Connection 0 Clock Output 1
inout	[31:0]	GPIO_1;					//	GPIO Connection 1 I/O
input			GPIO_CLKIN_N1;          //	GPIO Connection 1 Clock Input 0
input			GPIO_CLKIN_P1;          //	GPIO Connection 1 Clock Input 1
inout			GPIO_CLKOUT_N1;         //	GPIO Connection 1 Clock Output 0
inout			GPIO_CLKOUT_P1;         //	GPIO Connection 1 Clock Output 1
///////////////////////////////////////////////////////////////////
//=============================================================================
// REG/WIRE declarations
//=============================================================================


wire	CPU_CLK;
wire	CPU_RESET;
wire	CLK_18_4;
wire	CLK_25;

//	For Audio CODEC
wire		AUD_CTRL_CLK;	//	For Audio Controller

wire [31:0]	mSEG7_DIG;
reg	 [31:0]	Cont;
wire		VGA_CTRL_CLK;
wire [9:0]	mVGA_R;
wire [9:0]	mVGA_G;
wire [9:0]	mVGA_B;
wire [19:0]	mVGA_ADDR;
wire		DLY_RST;

//	For VGA Controller
wire			VGA_CLK;
wire	[9:0]	mRed;
wire	[9:0]	mGreen;
wire	[9:0]	mBlue;
wire			VGA_Read;	//	VGA data request

//	For Down Sample
wire	[3:0]	Remain;
wire	[9:0]	Quotient;

wire			mDVAL;



// DEFAULT LCD       //

/*
reg [31:0] mycnt;
reg myclk;
*/

initial begin

	hex_trash_i = 44'hFFFFFFFFFFF;
    bpm_o = 10'b0000111100;
    cnt_btn = 0;
    cnt_bpm = 0;
    cnt_beat = 0;
    freq = 50000000;
    freq_beat = 50000000;
    tmp1 = 0;
    tmp2 = 0;
end

assign switch_led_o = iSW[17];

assign beat_o[0] = beat_i[0];
assign beat_o[1] = beat_i[1];
assign beat_o[2] = beat_i[2];
assign beat_o[3] = beat_i[3];


//=============================================================================
// Structural coding
//=============================================================================
// initial //

assign DRAM_DQ 			= 32'hzzzzzzzz;
 
assign GPIO_CLKOUT_N0 	= 1'bz;     		  	
assign GPIO_CLKOUT_P0 	= 1'bz;     		         
 		          
assign GPIO_CLKOUT_N1 	= 1'bz;     		         
assign GPIO_CLKOUT_P1  	= 1'bz;     		         
assign AUD_ADCLRCK    	= 1'bz;     					
    					
assign AUD_DACLRCK 		= 1'bz;     					
assign oAUD_DACDAT 		= 1'bz;     					
assign AUD_BCLK 		= 1'bz;     						
assign oAUD_XCK 		= 1'bz;     				
assign ENET_D 			= 16'hzzzz;			
   						
assign I2C_SDAT 		= 1'bz;     						
assign oI2C_SCLK 		= 1'bz;     						
assign SD_DAT 			= 1'bz;     							
assign SD_DAT3 			= 1'bz;     						
assign SD_CMD 			= 1'bz;     						
assign oSD_CLK 			= 1'bz;     						
assign OTG_D   			= 16'hzzzz;	
assign SRAM_DQ 			= 32'hzzzzzzzz;				



always@(posedge iCLK_50)
    begin
        if(0)
        Cont	=	0;
        else
        Cont	=	Cont+1;
    end

//	All inout port turn to tri-state
assign	SD_DAT		=	1'bz;
assign	GPIO_0		=	32'hzzzzzzzz;
assign	GPIO_1		=	32'hzzzzzzzz;

//	Disable USB speed select
assign	OTG_FSPEED	=	1'bz;
assign	OTG_LSPEED	=	1'bz;

//	Turn On TV Decoder
assign	oTD2_RESET_N	=	1'b1;

//	Set SD Card to SD Mode
assign	SD_DAT3		=	1'b1;

//	Enable TV Decoder
assign	oTD1_RESET_N	=	1;

//	All inout port turn to tri-state
assign	DRAM_DQ		=	16'hzzzz;
assign	SRAM_DQ		=	16'hzzzz;
assign	SD_DAT		=	1'bz;

assign	oAUD_XCK	=	AUD_CTRL_CLK;
assign	AUD_ADCLRCK	=	AUD_DACLRCK;



//	7 segment LUT


//	Reset Delay Timer
Reset_Delay			r0	(	.iCLK(iCLK_50),.oRESET(DLY_RST)	);

VGA_Audio_PLL 		p1	(	.areset(~DLY_RST),.inclk0(iTD1_CLK27),.c0(VGA_CTRL_CLK),.c1(AUD_CTRL_CLK),.c2(VGA_CLK)	);

//	VGA Controller
VGA_Controller		u1	(	//	Host Side
							.iCursor_RGB_EN(4'h7),
							.oAddress(mVGA_ADDR),
							.iRed(mVGA_R),
							.iGreen(mVGA_G),
							.iBlue(mVGA_B),
							//	VGA Side
							.oVGA_R(oVGA_R),
							.oVGA_G(oVGA_G),
							.oVGA_B(oVGA_B),
							.oVGA_H_SYNC(oVGA_HS),
							.oVGA_V_SYNC(oVGA_VS),
							.oVGA_SYNC(oVGA_SYNC_N),
							.oVGA_BLANK(oVGA_BLANK_N),
							.oVGA_CLOCK(oVGA_CLOCK),
							//	Control Signal
							.iCLK(VGA_CTRL_CLK),
							.iRST_N(DLY_RST)	);

VGA_OSD_RAM			u2	(	//	Read Out Side
							.oRed(mVGA_R),
							.oGreen(mVGA_G),
							.oBlue(mVGA_B),
							.iVGA_ADDR(mVGA_ADDR),
							.iVGA_CLK(VGA_CLK),
							//	CLUT
							.iON_R(1023),
							.iON_G(1023),
							.iON_B(1023),
							.iOFF_R(0),
							.iOFF_G(0),
							.iOFF_B(512),
							//	Control Signals
							.iRST_N(DLY_RST)	);
							
//	Audio CODEC and video decoder setting
I2C_AV_Config 		u3	(	//	Host Side
							.iCLK(iCLK_50),
							.iRST_N(1),
							//	I2C Side
							.I2C_SCLK(oI2C_SCLK),
							.I2C_SDAT(I2C_SDAT)	);

AUDIO_DAC 			u4	(	//	Audio Side
							.oAUD_BCK(AUD_BCLK),
							.oAUD_DATA(oAUD_DACDAT),
							.oAUD_LRCK(AUD_DACLRCK),
							//	Control Signals
							.iSrc_Select(~(iSW[17] & audio_o)),
				            .iCLK_18_4(AUD_CTRL_CLK),
							.iRST_N(DLY_RST)	);

// DEFAULT FLASH  TEST //

flash_default_tester flash1(
    //CONTROL SIDE //
	.iDEFAULT    (iIRDA_RXD ),
	.iBUSSW      (1),
	.iTRIKEY     (1),
	.iCLK_28     (iCLK_28  ),

    //FLASH ROM SIDE //
	.FLASH_DQ      (FLASH_DQ      ),		
	.FLASH_DQ15_AM1(FLASH_DQ15_AM1),	
	.oFLASH_A      (oFLASH_A      ),
	.iFLASH_RY_N   (iFLASH_RY_N   ),
	.oFLASH_WE_N   (oFLASH_WE_N   ),	
	.oFLASH_RST_N  (oFLASH_RST_N  ),	
	.oFLASH_WP_N   (oFLASH_WP_N   ),	
	.oFLASH_BYTE_N (oFLASH_BYTE_N ),	
	.oFLASH_OE_N   (oFLASH_OE_N   ),	
	.oFLASH_CE_N   (oFLASH_CE_N   ),	
             
	//LCD SIDE//
	.oLCD_ON  (),
	.oLCD_BLON(),
	.LCD_D    (),
	.oLCD_RW  (),
	.oLCD_EN  (),
	.oLCD_RS  (),

    //DEFAULT SIDE//
	.iLCD_ON_1  (0),
	.iLCD_BLON_1(0),
	.LCD_D_1    (0),
	.iLCD_RW_1  (0),
	.iLCD_EN_1  (0),
	.iLCD_RS_1  (0)

);        




//reg [31:0] freq = 32'd50000000;
always@(posedge iCLK_50)
begin
    if(~inc_i[0]) begin
        tmp1 = tmp1 + 1;
        if(tmp1 == 1) begin
            if(bpm_o < 999)
                bpm_o = bpm_o + 1;
        end
    end
    if(inc_i[0]) begin
        tmp1 = 0;
    end

    if(~dec_i[0]) begin
        tmp2 = tmp2 + 1;
        if(tmp2 == 1) begin
            if(bpm_o > 0)
                bpm_o = bpm_o - 1;
        end
    end
    if(dec_i[0]) begin
        tmp2 = 0;
    end

    if(inc_i[1] ^ dec_i[1] == 1)
        cnt_btn = cnt_btn + 1;
    else
        cnt_btn = 0;

    // inc/dec per 0.1s.
    if(cnt_btn / ((freq - 1) / 10) > 0) begin
        if(inc_i[1] == 1'b0 && bpm_o < 999)
            bpm_o = bpm_o + 1;
        if(dec_i[1] == 1'b0 && bpm_o > 0)
            bpm_o = bpm_o - 1;
        cnt_btn = 0;
    end

    cnt_bpm = cnt_bpm + 1;

    freq_beat = ((freq - 1) / bpm_o * 60) + ((freq - 1) % bpm_o * 60 / bpm_o);

    if(cnt_bpm / freq_beat > 0) begin
        if(beat_o[cnt_beat] == 1'b1)
            audio_o = 1'b1;
        cnt_beat = (cnt_beat + 1) % 4;
        cnt_bpm = 0;
    end

    if(cnt_bpm > freq_beat / 10)
        audio_o = 1'b0;

/*
	mycnt = mycnt + 1;
	if(mycnt == 32'd5000000 & ~myclk)	// 0 
	begin
		myclk = ~myclk;
	end
	//freq_beat = ((freq - 1) / bpm_o * 60) + ((freq - 1) % bpm_o * 60 / bpm_o);
	//if(mycnt == freq_beat & myclk)	// 1: no sound

	if(mycnt == 32'd50000000 & myclk)	// 1: no sound
	begin
		myclk = ~myclk;
		mycnt = 0;
	end
*/
end

// display bpm.
three_digit_ss tds(bpm_o, bpm_ss1_o, bpm_ss2_o, bpm_ss3_o);

endmodule

