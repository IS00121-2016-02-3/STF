/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


function validarSiNumero() {
    var numeros = "0123456789";
    var peso = document.getElementsByName('peso');
   
    var verificarUsuario = false;
    var ingresa = false;
    var contador = 0;
    var contadorCC = 0;

    for (i = 0; i < document.registerform.nombre.value.length; i++) {
        if (numeros.indexOf(document.registerform.nombre.value.charAt(i), 0) != -1) {
            alert("El campo Nombre no debe contener un número");
            document.registerform.nombre.value = "";
            return false;
        }
    }

    for (i = 0; i < document.registerform.apellido.value.length; i++) {
        if (numeros.indexOf(document.registerform.apellido.value.charAt(i), 0) != -1) {
            alert("El campo Apellido no debe contener un número");
            document.registerform.apellido.value = "";
            return false;
        }
    }
    
    for (i = 0; i < document.registerform.peso.value.length; i++) {
        
        if (numeros.indexOf(document.registerform.peso.value.charAt(i), 0) == -1) {
            alert("El campo Identificación sólo debe contener numeros");
            document.registerform.peso.value = "";
            return false;
        }
    }
    
    if (document.solicitudForm.peso.value > 5000){
        alert("El tope máximo de la embarcación 5000 kg");
            document.registerform.identificacion.value = "";
            return false;
    }
    

    for (i = 0; i < document.registerform.telefono.value.length; i++) {
        if (numeros.indexOf(document.registerform.telefono.value.charAt(i), 0) == -1) {
            alert("El campo Telefono sólo debe contener numeros");
            document.registerform.telefono.value = "";
            return false;
        }
    }


    for (i = 0; i < document.registerform.usuario.value.length; i++) {
        ingresa = true;
        if (numeros.indexOf(document.registerform.usuario.value.charAt(i), 0) == -1) {
            verificarUsuario = true;
            contador = contador + 1;
        }
    }
    if (!verificarUsuario && ingresa) {
        alert("El campo Usuario debe tener al menos 5 letras");
        document.registerform.usuario.value = "";
        return false;
    } else if (verificarUsuario && ingresa && contador < 5) {
        alert("El campo Usuario debe tener al menos 5 letras");
        document.registerform.usuario.value = "";
        return false;
    }



    var p2 = document.getElementById("confirm-password").value;
    var p1 = document.getElementById("contaseña").value;

    var espacios = false;
    var cont = 0;

    while (!espacios && (cont < p1.length)) {
        if (p1.charAt(cont) == " ")
            espacios = true;
        cont++;
    }

    if (espacios) {
        alert("La contraseña no puede contener espacios en blanco");
        return false;
    }

    if (p1 != p2) {
        alert("Las contraseñas no son iguales");
        return false;
    }
}
 