package POO.Practicas;
import POO.Practicas.vehiculo;

public class sedan extends vehiculo {
    
    // this is the constructor
    public sedan() {
        this.tipo = "sedan";
        this.placa = "SSS-000";
        this.capacidad = 5;
    }

    public void imprimir() {
        System.out.println("Soy un vehículo ecoamigable soy 100% electrico");
    }
}
