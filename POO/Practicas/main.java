package POO.Practicas;

public class main {
    public static void main(String[] args) {
        vehiculo vehiculo = new vehiculo();
        cuatroXcuatro cuatroXcuatro = new cuatroXcuatro();
        modo modo = new modo();

        vehiculo.combustible();
        cuatroXcuatro.combustible();
        modo.combustible();
    }
    
}
