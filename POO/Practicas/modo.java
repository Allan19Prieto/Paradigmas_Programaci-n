package POO.Practicas;
import POO.Practicas.vehiculo;

public class modo extends vehiculo {

    public modo() {
        this.tipo = "Modo";
        this.placa = "MMM-000";
        this.capacidad = 2;
    }

    public void combustible() {
        System.err.println("Soy una Moto eléctrica");
    }
    
}
