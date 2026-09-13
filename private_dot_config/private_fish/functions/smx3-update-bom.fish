function smx3-update-bom
    set bom $argv[1]
    echo "Updated bill-of-materials to $bom"

    comby "import smx3:smx3.bill-of-materials::[ver];" "import smx3:smx3.bill-of-materials:$bom;" -review pom.deps
end
