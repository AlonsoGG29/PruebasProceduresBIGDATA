--CREAR TABLAS
-- =====================================================
-- PRÁCTICA: STORED PROCEDURES & TRIGGERS
-- Sistema de E-Learning Analytics
-- =====================================================

-- Crear base de datos
-- DROP DATABASE IF EXISTS elearning_analytics;
-- CREATE DATABASE elearning_analytics;
-- \c elearning_analytics

-- =====================================================
-- TABLAS OPERACIONALES (OLTP)
-- =====================================================

-- Tabla de usuarios
CREATE TABLE usuarios (
    user_id SERIAL PRIMARY KEY,
    email VARCHAR(255) UNIQUE NOT NULL,
    nombre VARCHAR(100),
    pais VARCHAR(50),
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    plan VARCHAR(20) CHECK (plan IN ('free', 'basic', 'premium')),
    activo BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabla de cursos
CREATE TABLE cursos (
    curso_id SERIAL PRIMARY KEY,
    titulo VARCHAR(200) NOT NULL,
    categoria VARCHAR(50),
    nivel VARCHAR(20) CHECK (nivel IN ('beginner', 'intermediate', 'advanced')),
    duracion_minutos INT,
    precio DECIMAL(10,2),
    instructor VARCHAR(100),
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    activo BOOLEAN DEFAULT TRUE
);

-- Tabla de inscripciones
CREATE TABLE inscripciones (
    inscripcion_id SERIAL PRIMARY KEY,
    user_id INT REFERENCES usuarios(user_id),
    curso_id INT REFERENCES cursos(curso_id),
    fecha_inscripcion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    precio_pagado DECIMAL(10,2),
    metodo_pago VARCHAR(50),
    completado BOOLEAN DEFAULT FALSE,
    fecha_completado TIMESTAMP,
    calificacion INT CHECK (calificacion BETWEEN 1 AND 5),
    UNIQUE(user_id, curso_id)
);

-- Tabla de actividad de aprendizaje (eventos)
CREATE TABLE actividad_aprendizaje (
    actividad_id SERIAL PRIMARY KEY,
    user_id INT REFERENCES usuarios(user_id),
    curso_id INT REFERENCES cursos(curso_id),
    tipo_evento VARCHAR(50), -- 'video_view', 'quiz_completed', 'resource_download'
    duracion_segundos INT,
    progreso_porcentaje DECIMAL(5,2),
    timestamp_evento TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    sesion_id VARCHAR(100),
    dispositivo VARCHAR(50)
);

-- Tabla de sesiones (para análisis de engagement)
CREATE TABLE sesiones (
    sesion_id VARCHAR(100) PRIMARY KEY,
    user_id INT REFERENCES usuarios(user_id),
    fecha_inicio TIMESTAMP,
    fecha_fin TIMESTAMP,
    duracion_minutos INT,
    paginas_vistas INT,
    cursos_accedidos INT
);

-- =====================================================
-- TABLAS ANALÍTICAS (OLAP / Data Warehouse)
-- =====================================================

-- Tabla de hechos diarios de usuario
CREATE TABLE fact_usuario_diario (
    fecha DATE,
    user_id INT,
    minutos_aprendizaje INT DEFAULT 0,
    cursos_accedidos INT DEFAULT 0,
    videos_vistos INT DEFAULT 0,
    quizzes_completados INT DEFAULT 0,
    sesiones INT DEFAULT 0,
    ultima_actualizacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (fecha, user_id)
);

-- Tabla de métricas de curso
CREATE TABLE metricas_curso (
    curso_id INT PRIMARY KEY,
    total_inscritos INT DEFAULT 0,
    total_completados INT DEFAULT 0,
    tasa_completado DECIMAL(5,2) DEFAULT 0,
    calificacion_promedio DECIMAL(3,2) DEFAULT 0,
    ingresos_total DECIMAL(12,2) DEFAULT 0,
    minutos_visualizados BIGINT DEFAULT 0,
    ultima_actualizacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabla de cohortes (para análisis de retención)
CREATE TABLE cohortes (
    cohorte_id SERIAL PRIMARY KEY,
    mes_registro VARCHAR(7), -- formato: YYYY-MM
    total_usuarios INT,
    usuarios_activos_mes1 INT DEFAULT 0,
    usuarios_activos_mes2 INT DEFAULT 0,
    usuarios_activos_mes3 INT DEFAULT 0,
    retencion_mes1 DECIMAL(5,2),
    retencion_mes2 DECIMAL(5,2),
    retencion_mes3 DECIMAL(5,2)
);

-- =====================================================
-- TABLAS DE CONTROL Y CALIDAD
-- =====================================================

-- Tabla de calidad de datos
CREATE TABLE data_quality_log (
    log_id SERIAL PRIMARY KEY,
    tabla VARCHAR(100),
    tipo_problema VARCHAR(100),
    descripcion TEXT,
    registros_afectados INT,
    severidad VARCHAR(20) CHECK (severidad IN ('low', 'medium', 'high', 'critical')),
    resuelto BOOLEAN DEFAULT FALSE,
    timestamp_deteccion TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabla de control ETL
CREATE TABLE etl_control (
    etl_id SERIAL PRIMARY KEY,
    nombre_proceso VARCHAR(100),
    fecha_ejecucion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    estado VARCHAR(20) CHECK (estado IN ('running', 'completed', 'failed')),
    registros_procesados INT,
    registros_insertados INT,
    registros_actualizados INT,
    registros_error INT,
    tiempo_ejecucion_segundos INT,
    mensaje_error TEXT
);

-- Tabla de auditoría
CREATE TABLE auditoria (
    auditoria_id SERIAL PRIMARY KEY,
    tabla VARCHAR(100),
    accion VARCHAR(50),
    user_id INT,
    registro_id INT,
    valores_anteriores JSONB,
    valores_nuevos JSONB,
    usuario_sistema VARCHAR(50) DEFAULT current_user,
    timestamp_accion TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);



--INSERTAR DATOS
-- =====================================================
-- INSERCIÓN DE DATOS DE PRUEBA
-- =====================================================

-- Usuarios (100 usuarios)
INSERT INTO usuarios (email, nombre, pais, plan, fecha_registro)
SELECT
    'user' || generate_series || '@email.com',
    'Usuario ' || generate_series,
    CASE (random() * 4)::INT
        WHEN 0 THEN 'Mexico'
        WHEN 1 THEN 'España'
        WHEN 2 THEN 'Argentina'
        WHEN 3 THEN 'Colombia'
        ELSE 'Chile'
    END,
    CASE (random() * 2)::INT
        WHEN 0 THEN 'free'
        WHEN 1 THEN 'basic'
        ELSE 'premium'
    END,
    CURRENT_TIMESTAMP - (random() * 365 || ' days')::INTERVAL
FROM generate_series(1, 100);

-- Cursos (30 cursos)
INSERT INTO cursos (titulo, categoria, nivel, duracion_minutos, precio, instructor) VALUES
('Python para Data Science', 'Data Science', 'beginner', 480, 49.99, 'Dr. Ana García'),
('Machine Learning Fundamentals', 'Data Science', 'intermediate', 720, 79.99, 'Dr. Carlos López'),
('SQL para Análisis de Datos', 'Data Engineering', 'beginner', 360, 39.99, 'Ing. María Rodríguez'),
('Big Data con Spark', 'Data Engineering', 'advanced', 600, 99.99, 'Ing. Juan Pérez'),
('Deep Learning con TensorFlow', 'Data Science', 'advanced', 900, 129.99, 'Dr. Laura Martínez'),
('ETL Pipelines con Airflow', 'Data Engineering', 'intermediate', 540, 89.99, 'Ing. Pedro Sánchez'),
('Visualización de Datos con Tableau', 'Data Analytics', 'beginner', 300, 44.99, 'Lic. Sofía González'),
('Statistics for Data Science', 'Data Science', 'intermediate', 420, 59.99, 'Dr. Diego Torres'),
('Data Warehousing Concepts', 'Data Engineering', 'intermediate', 480, 74.99, 'Ing. Carmen Jiménez'),
('Feature Engineering', 'Data Science', 'advanced', 360, 89.99, 'Dr. Roberto Díaz'),
('AWS Data Engineering', 'Data Engineering', 'advanced', 660, 119.99, 'Ing. Elena Vargas'),
('R Programming for Analysis', 'Data Analytics', 'beginner', 400, 49.99, 'Dr. Pablo Herrera'),
('Time Series Analysis', 'Data Science', 'advanced', 540, 94.99, 'Dr. Cristina Medina'),
('Data Modeling', 'Data Engineering', 'intermediate', 420, 69.99, 'Ing. Andrés Serrano'),
('A/B Testing', 'Data Analytics', 'intermediate', 300, 54.99, 'Lic. Beatriz Molina'),
('Natural Language Processing', 'Data Science', 'advanced', 780, 139.99, 'Dr. Gabriel Ortiz'),
('Docker for Data Engineers', 'Data Engineering', 'intermediate', 360, 64.99, 'Ing. Raquel Delgado'),
('Power BI Essentials', 'Data Analytics', 'beginner', 320, 44.99, 'Lic. Sergio Vega'),
('Advanced SQL', 'Data Engineering', 'advanced', 540, 84.99, 'Ing. Natalia Iglesias'),
('Pandas Masterclass', 'Data Science', 'intermediate', 480, 69.99, 'Dr. Óscar Ramírez'),
('Kafka for Streaming', 'Data Engineering', 'advanced', 600, 109.99, 'Ing. Daniela Fuentes'),
('Excel for Data Analysis', 'Data Analytics', 'beginner', 240, 29.99, 'Lic. Víctor Santana'),
('MongoDB for Analytics', 'Data Engineering', 'intermediate', 420, 74.99, 'Ing. Silvia Reyes'),
('Computer Vision', 'Data Science', 'advanced', 840, 149.99, 'Dr. Lorena Cortés'),
('dbt for Analytics', 'Data Engineering', 'intermediate', 360, 79.99, 'Ing. Rubén Pascual'),
('Business Intelligence', 'Data Analytics', 'intermediate', 480, 64.99, 'Lic. Mónica Gil'),
('MLOps Fundamentals', 'Data Science', 'advanced', 600, 119.99, 'Dr. Alberto Campos'),
('Data Quality', 'Data Engineering', 'intermediate', 300, 59.99, 'Ing. Teresa Núñez'),
('Web Scraping', 'Data Engineering', 'beginner', 240, 39.99, 'Ing. Enrique Domínguez'),
('Data Ethics', 'Data Analytics', 'beginner', 180, 24.99, 'Dr. Pilar Cano');

-- Inscripciones (generar 300 inscripciones aleatorias)
INSERT INTO inscripciones (user_id, curso_id, fecha_inscripcion, precio_pagado, metodo_pago, completado, calificacion)
SELECT
    (random() * 99 + 1)::INT,
    (random() * 29 + 1)::INT,
    CURRENT_TIMESTAMP - (random() * 180 || ' days')::INTERVAL,
    CASE
        WHEN random() < 0.3 THEN 0 -- 30% gratis
        ELSE (random() * 100 + 20)::DECIMAL(10,2)
    END,
    CASE (random() * 2)::INT
        WHEN 0 THEN 'tarjeta'
        WHEN 1 THEN 'paypal'
        ELSE 'transferencia'
    END,
    random() < 0.4, -- 40% completados
    CASE WHEN random() < 0.4 THEN (random() * 4 + 1)::INT ELSE NULL END
FROM generate_series(1, 300)
ON CONFLICT (user_id, curso_id) DO NOTHING;

-- Actividad de aprendizaje (generar 2000 eventos)
INSERT INTO actividad_aprendizaje (user_id, curso_id, tipo_evento, duracion_segundos, progreso_porcentaje, timestamp_evento, sesion_id, dispositivo)
SELECT
    i.user_id,
    i.curso_id,
    CASE (random() * 2)::INT
        WHEN 0 THEN 'video_view'
        WHEN 1 THEN 'quiz_completed'
        ELSE 'resource_download'
    END,
    (random() * 3600)::INT,
    (random() * 100)::DECIMAL(5,2),
    i.fecha_inscripcion + (random() * 30 || ' days')::INTERVAL,
    'session_' || (random() * 1000)::INT,
    CASE (random() * 2)::INT
        WHEN 0 THEN 'desktop'
        WHEN 1 THEN 'mobile'
        ELSE 'tablet'
    END
FROM inscripciones i
CROSS JOIN generate_series(1, 7)
LIMIT 2000;

-- Sesiones (generar 500 sesiones)
INSERT INTO sesiones (sesion_id, user_id, fecha_inicio, fecha_fin, duracion_minutos, paginas_vistas, cursos_accedidos)
SELECT
    'session_' || generate_series,
    (random() * 99 + 1)::INT,
    fecha_inicio,
    fecha_inicio + (duracion || ' minutes')::INTERVAL,
    duracion,
    (random() * 20 + 1)::INT,
    (random() * 3 + 1)::INT
FROM (
    SELECT
        generate_series,
        CURRENT_TIMESTAMP - (random() * 90 || ' days')::INTERVAL as fecha_inicio,
        (random() * 120 + 5)::INT as duracion
    FROM generate_series(1, 500)
) s;

-- =====================================================
-- ÍNDICES PARA OPTIMIZACIÓN
-- =====================================================

CREATE INDEX idx_inscripciones_user_id ON inscripciones(user_id);
CREATE INDEX idx_inscripciones_curso_id ON inscripciones(curso_id);
CREATE INDEX idx_actividad_user_id ON actividad_aprendizaje(user_id);
CREATE INDEX idx_actividad_curso_id ON actividad_aprendizaje(curso_id);
CREATE INDEX idx_actividad_timestamp ON actividad_aprendizaje(timestamp_evento);
CREATE INDEX idx_usuarios_plan ON usuarios(plan);
CREATE INDEX idx_usuarios_fecha_registro ON usuarios(fecha_registro);
CREATE INDEX idx_fact_fecha ON fact_usuario_diario(fecha);

-- =====================================================
-- VERIFICACIÓN
-- =====================================================

SELECT
    'Usuarios' as tabla, COUNT(*) as total FROM usuarios
UNION ALL
SELECT 'Cursos', COUNT(*) FROM cursos
UNION ALL
SELECT 'Inscripciones', COUNT(*) FROM inscripciones
UNION ALL
SELECT 'Actividad', COUNT(*) FROM actividad_aprendizaje
UNION ALL
SELECT 'Sesiones', COUNT(*) FROM sesiones;

-- Mensaje final
DO $$
BEGIN
    RAISE NOTICE '=====================================================';
    RAISE NOTICE 'Base de datos elearning_analytics creada exitosamente';
    RAISE NOTICE '=====================================================';
END $$;