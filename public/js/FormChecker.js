'use strict'
{
    function check(){
        console.log("hoge");
        const title = document.querySelector('input[name="title"]').value
        const instructor = document.querySelector('input[name="instructor"]').value
        const gakka = document.querySelector('select[name="gakka"]').value
        const week = document.querySelector('select[name="week"]').value
        const koma = document.querySelector('select[name="koma"]').value
        
        if(title === "" && instructor === "" && gakka === "" && week === "" && koma === ""){
            alert("授業名,講師名,学科,曜日,時限のどれかは必ず選択してください!");
            return false;
        }else{
            return true;
        }
    }
}