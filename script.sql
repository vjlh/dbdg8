create table "users" ("id" serial primary key not null, "name" varchar(255) not null, "apellido_usuario" varchar(255) not null, "fecha_nacimiento" date not null, "num_documento_usuario" integer not null, "pais_usuario" varchar(255) not null, "email" varchar(255) not null, "email_verified_at" timestamp(0) without time zone not null, "password" varchar(255) not null, "remember_token" varchar(100) null, "created_at" timestamp(0) without time zone null, "updated_at" timestamp(0) without time zone null);
create table "password_resets" ("email" varchar(255) not null, "token" varchar(255) not null, "created_at" timestamp(0) without time zone null);
create index "password_resets_email_index" on "password_resets" ("email");
create table "paises" ("id" serial primary key not null, "nombre_pais" varchar(255) not null, "moneda_pais" varchar(255) not null, "created_at" timestamp(0) without time zone null, "updated_at" timestamp(0) without time zone null);
create table "ciudades" ("id" serial primary key not null, "nombre_ciudad" varchar(255) not null, "idioma_ciudad" varchar(255) not null, "id_pais" integer not null, "created_at" timestamp(0) without time zone null, "updated_at" timestamp(0) without time zone null);
alter table "ciudades" add constraint "ciudades_id_pais_foreign" foreign key ("id_pais") references "paises" ("id") on delete cascade;
create table "hospedajes" ("id" serial primary key not null, "nombre_hospedaje" varchar(255) not null, "cadena_hospedaje" varchar(255) not null, "estrellas_hospedaje" integer not null, "estacionamiento_hospedaje" boolean not null, "piscina_hospedaje" boolean not null, "sauna_hospedaje" boolean not null, "zona_infantil_hospedaje" boolean not null, "gimnasio_hospedaje" boolean not null, "created_at" timestamp(0) without time zone null, "updated_at" timestamp(0) without time zone null);
create table "habitaciones" ("id" serial primary key not null, "capacidad_habitacion" integer not null, "banio_privado" boolean not null, "aire_acondicionado_habitacion" boolean not null, "disponibilidad" boolean not null, "tipo" varchar(255) not null, "fecha_inicio" date not null, "fecha_fin" date not null, "id_hospedaje" integer not null, "created_at" timestamp(0) without time zone null, "updated_at" timestamp(0) without time zone null);
alter table "habitaciones" add constraint "habitaciones_id_hospedaje_foreign" foreign key ("id_hospedaje") references "hospedajes" ("id") on delete cascade;
create table "restricciones" ("id" serial primary key not null, "nombre_restriccion" varchar(255) not null, "descripcion_restriccion" text not null, "sancion_restriccion" text not null, "id_ciudad" integer not null, "created_at" timestamp(0) without time zone null, "updated_at" timestamp(0) without time zone null);
alter table "restricciones" add constraint "restricciones_id_ciudad_foreign" foreign key ("id_ciudad") references "ciudades" ("id") on delete cascade;
create table "promociones" ("id" serial primary key not null, "nombre_promocion" varchar(255) not null, "descuento_promocion" integer not null, "descripcion_promocion" text not null, "created_at" timestamp(0) without time zone null, "updated_at" timestamp(0) without time zone null);
create table "paquetes" ("id" serial primary key not null, "num_dias" integer not null, "num_noches" integer not null, "precio_paquete" integer not null, "destino_paquete" varchar(255) not null, "created_at" timestamp(0) without time zone null, "updated_at" timestamp(0) without time zone null);
create table "aeropuertos" ("id" serial primary key not null, "nombre_aeropuerto" varchar(255) not null, "direccion_aeropuerto" varchar(255) not null, "telefono_aeropuerto" varchar(255) not null, "pagina_web" varchar(255) not null, "id_ciudad" integer not null, "created_at" timestamp(0) without time zone null, "updated_at" timestamp(0) without time zone null);
alter table "aeropuertos" add constraint "aeropuertos_id_ciudad_foreign" foreign key ("id_ciudad") references "ciudades" ("id") on delete cascade;
create table "aviones" ("id" serial primary key not null, "capacidad_avion" integer not null, "salidas_emergencia" integer not null, "sanitarios_avion" integer not null, "longitud_avion" integer not null, "envergadura_avion" varchar(255) not null, "created_at" timestamp(0) without time zone null, "updated_at" timestamp(0) without time zone null);
create table "vuelos" ("id" serial primary key not null, "hora_vuelo" time(0) without time zone not null, "duracion_vuelo" time(0) without time zone not null, "fecha_vuelo" date not null, "origen_vuelo" varchar(255) not null, "destino_vuelo" varchar(255) not null, "id_avion" integer not null, "id_aeropuerto" integer not null, "created_at" timestamp(0) without time zone null, "updated_at" timestamp(0) without time zone null);
alter table "vuelos" add constraint "vuelos_id_avion_foreign" foreign key ("id_avion") references "aviones" ("id") on delete cascade;
alter table "vuelos" add constraint "vuelos_id_aeropuerto_foreign" foreign key ("id_aeropuerto") references "aeropuertos" ("id") on delete cascade;
create table "beneficios" ("id" serial primary key not null, "nombre_beneficio" varchar(255) not null, "descripcion_beneficio" text not null, "precio_beneficio" integer not null, "created_at" timestamp(0) without time zone null, "updated_at" timestamp(0) without time zone null);
create table "seguros" ("id" serial primary key not null, "precio_seguro" integer not null, "tipo_seguro" varchar(255) not null, "precio_ticket" integer not null, "numero_pasajeros_seguros" integer not null, "created_at" timestamp(0) without time zone null, "updated_at" timestamp(0) without time zone null);
create table "transportes" ("id" serial primary key not null, "patente_transporte" integer not null, "modelo_transporte" varchar(255) not null, "num_asientos_transporte" integer not null, "num_puertas_transporte" integer not null, "aire_acondicionado_transporte" boolean not null, "puntuacion_transporte" integer not null, "fecha_inicio" date not null, "fecha_fin" date not null, "created_at" timestamp(0) without time zone null, "updated_at" timestamp(0) without time zone null);
create table "administradores" ("id" serial primary key not null, "id_user" integer not null, "created_at" timestamp(0) without time zone null, "updated_at" timestamp(0) without time zone null);
alter table "administradores" add constraint "administradores_id_user_foreign" foreign key ("id_user") references "users" ("id") on delete cascade;
create table "historiales" ("id" serial primary key not null, "descripcion" text not null, "id_user" integer not null, "created_at" timestamp(0) without time zone null, "updated_at" timestamp(0) without time zone null);
alter table "historiales" add constraint "historiales_id_user_foreign" foreign key ("id_user") references "users" ("id") on delete cascade;
create table "pasajeros" ("id" serial primary key not null, "nombre_pasajero" varchar(255) not null, "apellido_pasajero" varchar(255) not null, "edad_pasajero" integer not null, "tipo_pasajero" varchar(255) not null, "created_at" timestamp(0) without time zone null, "updated_at" timestamp(0) without time zone null);
create table "equipajes" ("id" serial primary key not null, "ancho" integer not null, "alto" integer not null, "largo" integer not null, "tipo_equipaje" varchar(255) not null, "id_pasajero" integer not null, "restriccion_equipaje" text not null, "created_at" timestamp(0) without time zone null, "updated_at" timestamp(0) without time zone null);
alter table "equipajes" add constraint "equipajes_id_pasajero_foreign" foreign key ("id_pasajero") references "pasajeros" ("id") on delete cascade;
create table "reservas" ("id" serial primary key not null, "monto_total_reserva" integer not null, "check_in" boolean not null, "id_paquete" integer null, "id_promocion" integer null, "id_seguro" integer null, "id_user" integer not null, "created_at" timestamp(0) without time zone null, "updated_at" timestamp(0) without time zone null);
alter table "reservas" add constraint "reservas_id_user_foreign" foreign key ("id_user") references "users" ("id") on delete cascade;
alter table "reservas" add constraint "reservas_id_seguro_foreign" foreign key ("id_seguro") references "seguros" ("id") on delete cascade;
alter table "reservas" add constraint "reservas_id_promocion_foreign" foreign key ("id_promocion") references "promociones" ("id") on delete cascade;
alter table "reservas" add constraint "reservas_id_paquete_foreign" foreign key ("id_paquete") references "paquetes" ("id") on delete cascade;
create table "asientos" ("id" serial primary key not null, "numero_asiento" integer not null, "letra_asiento" varchar(255) not null, "precio_asiento" integer not null, "disponibilidad" boolean not null, "cabina" varchar(255) not null, "id_reserva" integer not null, "id_avion" integer not null, "created_at" timestamp(0) without time zone null, "updated_at" timestamp(0) without time zone null);
alter table "asientos" add constraint "asientos_id_reserva_foreign" foreign key ("id_reserva") references "reservas" ("id") on delete cascade;
alter table "asientos" add constraint "asientos_id_avion_foreign" foreign key ("id_avion") references "aviones" ("id") on delete cascade;
create table "tickets" ("id" serial primary key not null, "tipo_pago" varchar(255) not null, "monto_pago" integer not null, "fecha_pago" date not null, "id_reserva" integer not null, "created_at" timestamp(0) without time zone null, "updated_at" timestamp(0) without time zone null);
alter table "tickets" add constraint "tickets_id_reserva_foreign" foreign key ("id_reserva") references "reservas" ("id") on delete cascade;
create table "beneficios_seguros" ("id" serial primary key not null, "id_beneficio" integer not null, "id_seguro" integer not null, "created_at" timestamp(0) without time zone null, "updated_at" timestamp(0) without time zone null);
alter table "beneficios_seguros" add constraint "beneficios_seguros_id_beneficio_foreign" foreign key ("id_beneficio") references "beneficios" ("id") on delete cascade;
alter table "beneficios_seguros" add constraint "beneficios_seguros_id_seguro_foreign" foreign key ("id_seguro") references "seguros" ("id") on delete cascade;
create table "pasajeros_reservas" ("id" serial primary key not null, "id_reserva" integer not null, "id_pasajero" integer not null, "created_at" timestamp(0) without time zone null, "updated_at" timestamp(0) without time zone null);
alter table "pasajeros_reservas" add constraint "pasajeros_reservas_id_pasajero_foreign" foreign key ("id_pasajero") references "pasajeros" ("id") on delete cascade;
alter table "pasajeros_reservas" add constraint "pasajeros_reservas_id_reserva_foreign" foreign key ("id_reserva") references "reservas" ("id") on delete cascade;
create table "habitaciones_reservas" ("id" serial primary key not null, "id_habitacion" integer not null, "id_reserva" integer not null, "created_at" timestamp(0) without time zone null, "updated_at" timestamp(0) without time zone null);
alter table "habitaciones_reservas" add constraint "habitaciones_reservas_id_habitacion_foreign" foreign key ("id_habitacion") references "habitaciones" ("id") on delete cascade;
alter table "habitaciones_reservas" add constraint "habitaciones_reservas_id_reserva_foreign" foreign key ("id_reserva") references "reservas" ("id") on delete cascade;
create table "transportes_reservas" ("id" serial primary key not null, "id_transporte" integer not null, "id_reserva" integer not null, "created_at" timestamp(0) without time zone null, "updated_at" timestamp(0) without time zone null);
alter table "transportes_reservas" add constraint "transportes_reservas_id_transporte_foreign" foreign key ("id_transporte") references "transportes" ("id") on delete cascade;
alter table "transportes_reservas" add constraint "transportes_reservas_id_reserva_foreign" foreign key ("id_reserva") references "reservas" ("id") on delete cascade;
