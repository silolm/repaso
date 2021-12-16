package unidad3;

import java.util.InputMismatchException;
import java.util.Scanner;

public class Pr02 {

	public static void main(String[] args) {
		Scanner teclado = new Scanner(System.in);

		boolean salir = true;
		int opcion;

		String alfabeto = "abcdefghijklmnopqrstuvwxyz";
		String newAlfabeto = null;
		String textAcifrar = "";
		String textAdescifrar = "";
		String encriptado = "";
		String desencriptado = "";
		String seguir = teclado.nextLine();

		int clave = 0;

		do { // hasta que no pongamos salir = true hacemos..
			System.out.println("     CRIPTOGRAFIA CESAR\n");
			System.out.println("1.-Configurar");
			System.out.println("2.-Encriptar");
			System.out.println("3.-Desencriptar");
			System.out.println("4.-Salir");
			try {
				System.out.println("Elige una opción (1-4):");
				opcion = teclado.nextInt();
				switch (opcion) {
				case 1:
					salir = false;
					System.out.println("      CRIPTOGRAFIA CESAR-CONFIGURAR\n");
					System.out.println("Alfabeto actual: " + alfabeto);
					System.out.println("Modulo actual: " + alfabeto.length() + "\n");
					System.out.print("Nuevo alfabeto (enter para no cambiar): ");
					newAlfabeto = teclado.next();
					if (seguir.isEmpty()) {
						System.out.println("Presione cualquier tecla para continuar...");
						try {
							seguir = teclado.nextLine();
							salir = true;
						} catch (Exception e) {
						}
					} else {
						alfabeto = newAlfabeto;
						System.out.println("Nuevo alfabeto: " + newAlfabeto);
						System.out.println("Nuevo módulo: " + newAlfabeto.length() + "\n");
						try {
							seguir = teclado.nextLine();
							salir = true;
						} catch (Exception e) {
						}
					}
					break;
				case 2:
					salir = false;

					System.out.println("      CRIPTOGRAFIA CESAR-ENCRIPTAR\n");

					System.out.print("Introduce una clave(1-36): ");
					clave = teclado.nextInt();
					teclado.nextLine();

					System.out.print("Texto a cifrar: ");
					textAcifrar = teclado.nextLine();

					for (int i = 0; i < textAcifrar.length(); i++) {
						int posicion = alfabeto.indexOf(textAcifrar.charAt(i));
						if (posicion >= 0) {
							encriptado += alfabeto.charAt((posicion + clave) % alfabeto.length());
							// SE UTILIZA LA OPERACION MODULO PARA VOLVER AL INICIO DEL
							// ALFABETO CUANDO SE SALE POR EL FINAL
						} else {
							encriptado += textAcifrar.charAt(i);
						}
					}

					System.out.println("   Texto filtrado: " + textAcifrar);
					System.out.println("   Texto cifrado: " + encriptado + "\n");
					System.out.println("Presione cualquier tecla para continuar...");
					try {
						seguir = teclado.nextLine();
						salir = true;
					} catch (Exception e) {
					}
					break;
				case 3:
					salir = false;
					System.out.println("      CRIPTOGRAFIA CESAR-ENCRIPTAR\n");

					System.out.print("Introduce una clave(1-36): ");
					clave = teclado.nextInt();
					teclado.nextLine();

					System.out.print("Texto a descifrar: ");
					textAdescifrar = teclado.nextLine();

					for (int i = 0; i < textAdescifrar.length(); i++) {
						int posicion = alfabeto.indexOf(textAdescifrar.charAt(i));
						if (posicion >= 0) {
							desencriptado += alfabeto.charAt((posicion - clave) % alfabeto.length());
							// SE UTILIZA LA OPERACION MODULO PARA VOLVER AL INICIO DEL
							// ALFABETO CUANDO SE SALE POR EL FINAL
						} else {
							desencriptado += textAdescifrar.charAt(i);
						}
					}

					System.out.println("   Texto filtrado: " + textAcifrar);
					System.out.println("   Texto descifrado: " + desencriptado + "\n");
					System.out.println("Presione cualquier tecla para continuar...");
					try {
						seguir = teclado.nextLine();
						salir = true;
					} catch (Exception e) {
					}

					break;
				case 4:
					salir = false;
					break;
				default:
					System.out.println("Solo números entre el 1 y el 4");
				}
			} catch (InputMismatchException e) {
				System.out.println("Debes insertar un número!\n");
				teclado.next();
			}
		} while (salir);

	}
}
