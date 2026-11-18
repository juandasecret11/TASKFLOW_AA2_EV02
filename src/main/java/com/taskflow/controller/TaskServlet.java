
package com.taskflow.controller;

import com.taskflow.repository.TaskRepository;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/tasks")
public class TaskServlet extends HttpServlet {

    private final TaskRepository repository = new TaskRepository();

    // CONSULTAR TAREAS
    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        try {
            request.setAttribute("tasks", repository.findAll());

            request.getRequestDispatcher("/tasks.jsp")
                   .forward(request, response);

        } catch (SQLException e) {
            throw new ServletException(
                "Error al consultar las tareas", e);
        }
    }

    // REGISTRAR, EDITAR Y ELIMINAR
    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        try {

            if ("update".equals(action)) {

                int id = Integer.parseInt(
                    request.getParameter("id"));

                String title = request.getParameter("title");
                String category = request.getParameter("category");

                repository.update(id, title, category);

            } else if ("delete".equals(action)) {

                int id = Integer.parseInt(
                    request.getParameter("id"));

                repository.delete(id);

            } else {

                String title = request.getParameter("title");
                String category = request.getParameter("category");

                repository.save(title, category);
            }

            response.sendRedirect(
                request.getContextPath() + "/tasks");

        } catch (SQLException | NumberFormatException e) {

            throw new ServletException(
                "Error al procesar la tarea", e);
        }
    }
}
