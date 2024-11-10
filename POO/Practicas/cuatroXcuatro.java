package POO.Practicas;
import POO.Practicas.vehiculo;

public class cuatroXcuatro extends vehiculo {

    public cuatroXcuatro() {
        this.tipo = "4x4";
        this.placa = "CXC-000";
        this.capacidad = 4;
    }

    public void combustible() {
        System.err.println("Soy un vehículo Dísel");
    }   
    
}
