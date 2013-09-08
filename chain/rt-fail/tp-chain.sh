#下面一行是用来设置‘柱子’的宽度
set boxwidth 1.0 absolute

#下面两行分别代表不同的画柱子风格。第一种是用颜色去区分。第二种是用斜线来区分柱子。
set style fill solid 1.00 border -1
#set style fill pattern 10 border -1

set style histogram clustered gap 1 title offset character 0, 0, 0
set datafile missing '-'
set style data histograms

# 黑白图片
#set term postscript eps monochrome blacktext "Helvetica" 24
# 彩色图片
set term postscript eps enhanced color blacktext "Helvetica" 24

# right top表示位置显示。Left 表示框子里的字左对齐。width X用来限定框子大小。box X用来表示选用哪种类型的框子--颜色可能不同。
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
	

