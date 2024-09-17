% Base de conocimientos
% Definimos condiciones médicas y niveles de actividad física como hechos.
condicion(obesidad).
condicion(diabetes).
condicion(anemia).

nivel_actividad(sedentario).
nivel_actividad(moderado).
nivel_actividad(activo).

% Recomendaciones basadas en condiciones médicas
recomendacion_nutricional(obesidad, 'Recomiendo una dieta baja en carbohidratos y grasas.').
recomendacion_nutricional(diabetes, 'Recomiendo una dieta baja en azúcar y carbohidratos refinados.').
recomendacion_nutricional(anemia, 'Recomiendo alimentos ricos en hierro como espinacas y carnes rojas.').

% Recomendaciones basadas en niveles de actividad física
recomendacion_actividad(sedentario, 'Aumenta tu consumo de proteínas y fibra para mejorar el metabolismo.').
recomendacion_actividad(moderado, 'Mantén una dieta balanceada con suficientes carbohidratos para energía.').
recomendacion_actividad(activo, 'Aumenta el consumo de carbohidratos y proteínas para soportar el nivel de actividad.').

% Lógica para obtener recomendaciones según la condición médica y el nivel de actividad física
obtener_recomendacion(Condicion, Nivel_Actividad) :-
    condicion(Condicion),
    nivel_actividad(Nivel_Actividad),
    recomendacion_nutricional(Condicion, Rec_nutricional),
    recomendacion_actividad(Nivel_Actividad, Rec_actividad),
    format('Recomendación nutricional: ~w~n', [Rec_nutricional]),
    format('Recomendación basada en actividad física: ~w~n', [Rec_actividad]).

% Flujo conversacional simulado
iniciar :-
    write('Bienvenido al sistema experto de recomendaciones nutricionales.'), nl,
    write('Por favor, ingrese su condicion medica (obesidad, diabetes, anemia): '), nl,
    read(Condicion),
    write('Ingrese su nivel de actividad fisica (sedentario, moderado, activo): '), nl,
    read(Nivel_Actividad),
    obtener_recomendacion(Condicion, Nivel_Actividad).

