OUTPUT_DIR=results

rm -rf $OUTPUT_DIR
mkdir $OUTPUT_DIR
mkdir $OUTPUT_DIR/html

jmeter -n -t chat.jmx -l $OUTPUT_DIR/chat.jtl -e -o $OUTPUT_DIR/html

