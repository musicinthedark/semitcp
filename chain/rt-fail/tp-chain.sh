#����һ�����������á����ӡ��Ŀ��
set boxwidth 1.0 absolute

#�������зֱ����ͬ�Ļ����ӷ�񡣵�һ��������ɫȥ���֡��ڶ�������б�����������ӡ�
set style fill solid 1.00 border -1
#set style fill pattern 10 border -1

set style histogram clustered gap 1 title offset character 0, 0, 0
set datafile missing '-'
set style data histograms

# �ڰ�ͼƬ
#set term postscript eps monochrome blacktext "Helvetica" 24
# ��ɫͼƬ
set term postscript eps enhanced color blacktext "Helvetica" 24

# right top��ʾλ����ʾ��Left ��ʾ�������������롣width X�����޶����Ӵ�С��box X������ʾѡ���������͵Ŀ���--��ɫ���ܲ�ͬ��
#set key right top Left reverse width 0 box 3
set key right top Right

set xlabel "Path length in number of hops(N)" 0,0
set ylabel "Throghput(Kbps)" 0,0
set output "tp-chain.eps"
plot './ap-dupack/throughput' u 2:xtic(1) t 'TCP-AP', \
	'./ap-nodupack/throughput' u 2 t 'TCP-AP Without Duplicate ACK', \
	'./semi-dupack/throughput' u 2 t 'Semi-TCP', \
	'./semi-dupack-use-ap/throughput' u 2 t 'Semi-TCP Using Adaptive Pacing', \
	'./semi-nodupack/throughput' u 2 t 'Semi-TCP Without Duplicate ACK'
	

