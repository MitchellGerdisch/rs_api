if [ $# -ne 1 ]
then
	echo "USAGE: $0 PRICING_FILTER_FROM_CAT"
	echo "Pass the pricing filter from the Cheapest Cloud CAT in single quotes"
fi

price_filter=${1}

echo ${price_filter} |
sed 's/ //g' 

