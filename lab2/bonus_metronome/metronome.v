module metronome(
    clock_i,
    switch_i,
    beat_i,
    inc_i,
    dec_i,
	AUD_ADCLRCK,					//	Audio CODEC ADC LR Clock
	iAUD_ADCDAT,					//	Audio CODEC ADC Data
	AUD_DACLRCK,					//	Audio CODEC DAC LR Clock
	oAUD_DACDAT,					//	Audio CODEC DAC Data
	AUD_BCLK,						//	Audio CODEC Bit-Stream Clock
	oAUD_XCK,						//	Audio CODEC Chip Clock
    switch_led_o,
    bpm_ss1_o,
    bpm_ss2_o,
    bpm_ss3_o,
    beat_o,
);

input clock_i;
input switch_i;
input [3:0] beat_i;

input [1:0] inc_i, dec_i; // 0:normal  1:fast

output [6:0] bpm_ss1_o, bpm_ss2_o, bpm_ss3_o;
output switch_led_o;

output wire [3:0] beat_o;

inout	AUD_ADCLRCK;			//	Audio CODEC ADC LR Clock
input	iAUD_ADCDAT;			//	Audio CODEC ADC Data
inout	AUD_DACLRCK;			//	Audio CODEC DAC LR Clock
output	oAUD_DACDAT;			//	Audio CODEC DAC Data
inout	AUD_BCLK;				//	Audio CODEC Bit-Stream Clock
output	oAUD_XCK;				//	Audio CODEC Chip Clock

integer cnt_btn, cnt_bpm, cnt_beat, freq, freq_beat; // unit = sec.

reg [9:0] bpm_o;
reg audio_o;
wire        AUD_CTRL_CLK;   //  For Audio Controller

wire        DLY_RST;

initial begin
    bpm_o = 10'b0000111100;
    cnt_btn = 0;
    cnt_bpm = 0;
    cnt_beat = 0;
    freq = 50000000;
    freq_beat = 50000000;

end

assign switch_led_o = switch_i;

assign beat_o[0] = beat_i[0];
assign beat_o[1] = beat_i[1];
assign beat_o[2] = beat_i[2];
assign beat_o[3] = beat_i[3];

assign  oAUD_XCK    =   AUD_CTRL_CLK;
assign  AUD_ADCLRCK =   AUD_DACLRCK;

reset_delay_m r(.iCLK(clock_i),.oRESET(DLY_RST));

integer tmp1;
integer tmp2;

initial begin
	tmp1 = 0;
	tmp2 = 0;
end

always @(posedge clock_i) begin
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
end

// display bpm.
three_digit_ss tds(bpm_o, bpm_ss1_o, bpm_ss2_o, bpm_ss3_o);

AUDIO_DAC ad(
    //	Audio Side
    .oAUD_BCK(AUD_BCLK),
    .oAUD_DATA(oAUD_DACDAT),
    .oAUD_LRCK(AUD_DACLRCK),
    //	Control Signals
    .iSrc_Select(audio_o & switch_i),
    //.iSrc_Select(1),
    .iCLK_18_4(AUD_CTRL_CLK),
    .iRST_N(DLY_RST));

endmodule
