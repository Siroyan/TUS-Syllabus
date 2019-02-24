'use strict'

{

let rigakubu = [
    {val:"S", txt:"数学科"},
    {val:"OS", txt:"応用数学科"},
    {val:"K", txt:"化学科"},
    {val:"OK", txt:"応用化学科"},
    {val:"B", txt:"物理科"},
    {val:"OB", txt:"応用物理科"}
];

let kougakubu = [
    {val:"M", txt:"機械工学科"},
    {val:"E", txt:"電気工学科"},
    {val:"i", txt:"情報工学科"},
    {val:"A", txt:"建築学科"},
    {val:"C", txt:"工業化学科"}
];

const gakubuSelector = document.querySelector('select[name="gakubu"]');
const gakkaSelector  = document.querySelector('select[name="gakka"]');

gakubuSelector.addEventListener('change', () => {
    resetGakkaOptionsWithoutPlaceholder();
    let index = gakubuSelector.selectedIndex;
    switch(index) {
        case 0:
            //any selected
            break;
        case 1:
            //理学部 selected
            for(let i=0; i < rigakubu.length; i++){
                let option = document.createElement("option");
                option.value = rigakubu[i].val;
                option.text = rigakubu[i].txt;
                gakkaSelector.appendChild(option)
            }
            break;
        case 2:
            //工学部 selected
            for(let i=0; i < kougakubu.length; i++){
                let option = document.createElement("option");
                option.value = kougakubu[i].val;
                option.text = kougakubu[i].txt;
                gakkaSelector.appendChild(option)
            }
            break;
        //TODO Others Gakka
    }
});

function resetGakkaOptionsWithoutPlaceholder(){
    for(let i = gakkaSelector.options.length - 1; i > 0; i--){
        gakkaSelector.removeChild(gakkaSelector.options[i]);
    }
}

}