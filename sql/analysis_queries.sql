-- =========================================
-- Sales Data Analysis Project
-- Tables:
-- CLIENTES, PRODUCTOS, VENTAS, EMPLEADOS, CATEGORIAS, DETALLE_VENTA
-- =========================================

-- 1. Total revenue
SELECT 
    SUM(dv.cantidad * dv.precio_unitario) AS total_revenue
FROM detalle_venta dv;

-- 2. Total orders
SELECT 
    COUNT(*) AS total_orders
FROM ventas;

-- 3. Top 10 best-selling products
SELECT 
    p.nombre AS product_name,
    SUM(dv.cantidad) AS total_quantity_sold,
    SUM(dv.cantidad * dv.precio_unitario) AS total_revenue
FROM detalle_venta dv
JOIN productos p ON dv.producto_id = p.producto_id
GROUP BY p.nombre
ORDER BY total_revenue DESC
FETCH FIRST 10 ROWS ONLY;

-- 4. Monthly sales trend
SELECT 
    TO_CHAR(v.fecha_venta, 'YYYY-MM') AS sales_month,
    SUM(dv.cantidad * dv.precio_unitario) AS monthly_revenue
FROM ventas v
JOIN detalle_venta dv ON v.venta_id = dv.venta_id
GROUP BY TO_CHAR(v.fecha_venta, 'YYYY-MM')
ORDER BY sales_month;

-- 5. Revenue by category
SELECT 
    c.nombre AS category_name,
    SUM(dv.cantidad * dv.precio_unitario) AS total_revenue
FROM detalle_venta dv
JOIN productos p ON dv.producto_id = p.producto_id
JOIN categorias c ON p.categoria_id = c.categoria_id
GROUP BY c.nombre
ORDER BY total_revenue DESC;
