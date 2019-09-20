<?php 
    function toFloat($num) {
        $dotPos = strrpos($num, '.');
        $commaPos = strrpos($num, ',');
        $sep = (($dotPos > $commaPos) && $dotPos) ? $dotPos : 
            ((($commaPos > $dotPos) && $commaPos) ? $commaPos : false);
       
        if (!$sep) {
            return floatval(preg_replace("/[^0-9]/", "", $num));
        } 

        return floatval( preg_replace("/[^0-9]/", "", substr($num, 0, $sep)) . '.' .
                        preg_replace("/[^0-9]/", "", substr($num, $sep+1, strlen($num))));
    } 


    function calcPrecioTotal($carrito){
        
        $total = 0.0;

        foreach ($carrito as $id => $item) { 
           $subtotal = toFloat($item['cantidad']) * toFloat($item['precio']);
           $total = $total + $subtotal;
        }

        return $total;
    }

    function isLogged(){
        
        if(isset($_SESSION['login'])){
            return TRUE;
        }else{
            return FALSE;   
        }

    }

?>