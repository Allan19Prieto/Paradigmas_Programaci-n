package POO.Practicas;

// This class 
public class vehiculo {

    String tipo;
    String placa;
    int capacidad;

    // this is the constructor
    public vehiculo() {
        this.tipo = "sedan";
        this.placa = "NNN-000";
        this.capacidad = 5;
    }

    // this is the other constructor
    public vehiculo(String tipo, String placa, int capacidad){
        this.tipo = tipo;
        this.placa = placa;
        this.capacidad = capacidad;
    }

    public void combustible() {
        System.err.println("Soy un vehículo ecoamigable soy 100% electrico");
    }
    
}
