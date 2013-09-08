#set title "SemiTcp and TCP-AP Delay"
# �ڰ�ͼƬ
#set term postscript eps monochrome blacktext "Helvetica" 24
# ��ɫͼƬ
set term postscript eps enhanced color blacktext "Helvetica" 24

set grid
set boxwidth 20

set xlabel "Path length in number of hops(N)" 0,0
set ylabel "Delay(ms)"
set output 'delay-chain.eps'
# right top��ʾλ����ʾ��Left ��ʾ�������������롣width X�����޶����Ӵ�С��box X������ʾѡ���������͵Ŀ���--��ɫ���ܲ�ͬ��
#set key right top Left reverse width 0 box 3
set key left top Left reverse 

plot './ap-dupack/delay' u 1:2 title 'TCP-AP' with linespoints,\
	'./ap-nodupack/delay' u 1:2 title 'TCP-AP Without Duplicate ACK' with linespoints,\
	'./semi-dupack/delay' u 1:2 title 'Semi-TCP' with linespoints,\
	'./semi-dupack-use-ap/delay' u 1:2 title 'Semi-TCP Using Adaptive Pacing' with linespoints,\
	'./semi-nodupack/delay' u 1:2 title 'Semi-TCP Without Duplicate ACK' with linespoints
