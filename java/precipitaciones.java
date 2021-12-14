package unidad3;

import java.text.DecimalFormat;
import java.util.Scanner;

public class Pr01 {

	public static void main(String[] args) {
		Scanner teclado = new Scanner(System.in);
		DecimalFormat formato = new DecimalFormat("#.###");

		String[] meses = { "Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Septiembre",
				"Octubre", "Noviembre", "Diciembre" };
		Double[] precipitaciones = new Double[12];

		boolean repite;
		int indice = 0;

		double suma = 0;
		double sumaCuadrado = 0;
		double media = 0;
		double desviacion = 0;

		// Introducir Precipitaciones por mes y almacenarlas en el array.
		for (int i = 0; i < precipitaciones.length; i++) {

			// Generamos un DoWhile para que nos vuelva a pedir que ingresemos por teclado
			// las precipitaciones tantas veces fallemos.
			do {
				try {
					// Recogemos mediante el try lo que generan las excepciones, en nuestro caso el
					// método NextLine.
					repite = false;
					System.out.print(meses[i] + ": ");
					String valor = teclado.nextLine();

					// Generamos un condicional donde almacene el valor introducido si es mayor o
					// igual a 0, si no, activamos la varible a true para que vuelva a preguntarnos.
					if (Double.parseDouble(valor) >= 0)
						precipitaciones[i] = Double.parseDouble(valor);
					else
						repite = true;
				} catch (NumberFormatException e) {
					System.out.println("No es valor numérico");
					repite = true;
				}
			} while (repite);
		} // for

		for (int i = 0; i < precipitaciones.length; i++)
			if (precipitaciones[i] > precipitaciones[indice])
				indice = i;

		System.out.println("\nEl mes con mayor precipitaciones es: " + meses[indice] + " con "
				+ formato.format(precipitaciones[indice]) + " mm");

		// Media Aritmética
		for (int i = 0; i < precipitaciones.length; i++) {
			suma += precipitaciones[i];
			media = suma / precipitaciones.length;
		}
		System.out.println("Media: " + formato.format(media));
		
		// Desviación típica
		for (int i = 0; i < precipitaciones.length; i++) {
			sumaCuadrado += Math.pow(precipitaciones[i] - media, 2);
			desviacion = Math.sqrt(sumaCuadrado / precipitaciones.length);
		}
		System.out.println("Desviación: " + formato.format(desviacion));
	}
}
