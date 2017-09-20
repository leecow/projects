VARCHECK="11"

function my_if_function()
{
    if [ ${VARCHECK} -eq "10" ]
        then
        echo "first check"
        echo ${VARCHECK}
    fi

    if [ ${VARCHECK} -eq "11" ]
        then
        echo "second check"
        echo ${VARCHECK}
    fi
}

echo "Begin ..."
my_if_function
echo "End ..."