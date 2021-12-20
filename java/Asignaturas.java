package unidad3;

import java.util.InputMismatchException;
import java.util.Scanner;

public class Pr03 {

	public static void main(String[] args) {
		Scanner teclado = new Scanner(System.in);
		boolean salir = false;
		int opcion;
		int n = 0;
		int mes = 0;
		int horas = 0;
		String[] asignaturas = new String[n];
		double[][] horasArray = new double[0][0];

		do {
			System.out.println("          HORAS DE ESTUDIO\n \n 1.-Definir Tablas.\n 2.-Modificar horas.\n "
					+ "3.-Total horas por asignatura.\n 4.-Total horas por meses\n "
					+ "5.-Nombre y horas de asignaturas más estudiada.\n 6.-Salir\n \n");
			try {
				System.out.println("       Escoja una opción(1-6):");
				opcion = teclado.nextInt();
				teclado.nextLine();
				switch (opcion) {
				case 1:
					salir = true;
					System.out.println("Cuántas asignaturas:");
					n = teclado.nextInt();
					horasArray = new double[n][12];
					teclado.nextLine();
					asignaturas = new String[n];
					for (int i = 0; i < asignaturas.length; i++) {
						System.out.println("Asignatura " + n + ":");
						asignaturas[i] = teclado.nextLine();
					} // fin for
					System.out.println("  Pulse ENTER para menú...");
					teclado.nextLine();
					break;
				case 2:
					//if (asignaturas.length == 0) {
					//	System.out.println("No tienes asignaturas, introducelas...");
					//	salir = false;
					//}

					salir = true;
					System.out.println("Asignatura: ");
					String iniAsignatura = teclado.nextLine();
					String foundAsignatura = "";
					int indexAsignatura = -1;
					for (int i = 0; i < asignaturas.length; i++) {
						if (asignaturas[i].contains(iniAsignatura)) {
							foundAsignatura = asignaturas[i];
							indexAsignatura = i;
						}
					}

					if (foundAsignatura.equals("")) {
						// tratas asignatura no encontrada
						System.out.println("No encontrada");
						salir = true;
						break;
					}

					System.out.println("Encontrada: " + asignaturas[indexAsignatura]);
					boolean repite = true;
					do {
						try {
							System.out.print("Mes(1-12): ");
							mes = teclado.nextInt();
							if (mes >= 1 && mes <= 12) {
								System.out.println("Horas:");
								horas = teclado.nextInt();
								horasArray[indexAsignatura][mes] = horas;
								System.out.print("asignatura: " + asignaturas[indexAsignatura] + ", mes: " + mes
										+ ", horas: " + horasArray[indexAsignatura][mes]);
								repite = false;
							}
						} catch (NumberFormatException e) {
							System.out.println("No es un valor numérico");
						}
					} while (repite);
					System.out.println("  Pulse ENTER para menú...");
					teclado.nextLine();
					break;
				case 3:
					salir = true;
					System.out.println("      HORAS ANUALES POR ASIGNATURA");
					System.out.println("  Pulse ENTER para menú...");
					teclado.nextLine();
					break;
				case 4:
					salir = true;
					System.out.println("      HORAS TOTALES MENSUALES");
					System.out.println("  Pulse ENTER para menú...");
					teclado.nextLine();
					break;
				case 5:
					salir = true;
					System.out.println("La más estudiada es ");
					System.out.println("  Pulse ENTER para menú...");
					teclado.nextLine();
					break;

				case 6:
					salir = false;
					break;
				default:
					System.out.println("Solo numeros entre el uno y el 6!!!");

				} // fin switch
			} catch (InputMismatchException e) {
				System.out.println("Debes insertar un número!\n");
				teclado.next();
			} // fin catch
		} while (salir); // fin do while
	}

}
