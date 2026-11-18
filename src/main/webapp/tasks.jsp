<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ page import="java.util.List, java.util.Map" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>TaskFlow - Gestión de tareas</title>
</head>
<body>

    <h1>TaskFlow</h1>

    <h2>Registrar nueva tarea</h2>

    <form action="tasks" method="POST">
        <input type="text" name="title"
               placeholder="Nombre de la tarea" required>

        <select name="category" required>
            <option value="Estudio">Estudio</option>
            <option value="Trabajo">Trabajo</option>
            <option value="Personal">Personal</option>
        </select>

        <button type="submit">Guardar tarea</button>
    </form>

    <hr>

    <h2>Mis tareas</h2>

    <%
        List<Map<String, Object>> tasks =
            (List<Map<String, Object>>) request.getAttribute("tasks");

        if (tasks != null && !tasks.isEmpty()) {
            for (Map<String, Object> task : tasks) {
    %>

        <h3><%= task.get("title") %></h3>
        <p>ID: <%= task.get("id") %></p>
        <p>Categoría: <%= task.get("category") %></p>

        <form action="tasks" method="POST">
            <input type="hidden" name="action" value="update">
            <input type="hidden" name="id"
                   value="<%= task.get("id") %>">

            <input type="text" name="title"
                   value="<%= task.get("title") %>" required>

            <select name="category">
                <option value="Estudio">Estudio</option>
                <option value="Trabajo">Trabajo</option>
                <option value="Personal">Personal</option>
            </select>

            <button type="submit">Actualizar</button>
        </form>

        <form action="tasks" method="POST">
            <input type="hidden" name="action" value="delete">
            <input type="hidden" name="id"
                   value="<%= task.get("id") %>">

            <button type="submit">Eliminar</button>
        </form>

        <hr>

    <%
            }
        } else {
    %>
        <p>No hay tareas registradas.</p>
    <%
        }
    %>

</body>
</html>