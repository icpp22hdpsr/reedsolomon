filename=testfile
inputdir=path_to_your_input
outputdir=path_to_your_output
k=6
m=2
dn=10
bs=1
mem=8

# 4k 4096
# 1M 1048576
# 4M 4194304
# 16M 16777216
# 64M 67108864
# 128M 134217728
# 256M 268435456

go build -o main ./main.go

./main -md init -k $k -m $m -dn $dn -bs $bs -mem $mem
./main -md encode -f $inputdir/$filename -conStripes 100 -o

# to read a file
./main -md read -f $filename -conStripes 100 -sp $outputdir/$filename

srchash=(`sha256sum $inputdir/$filename|tr ' ' ' '`)
dsthash=(`sha256sum $outputdir/$filename|tr ' ' ' '`)
echo $srchash
echo $dsthash
if [ $srchash == $dsthash ];then 
    echo "hash check succeeds"
else
    echo "hash check fails"
fi
