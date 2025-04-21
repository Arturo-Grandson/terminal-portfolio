import '../models/command.dart';
import '../models/command_response.dart' as response;
import '../models/project.dart';

class CommandService {
  final List<Project> _projects = [
    const Project(
      name: 'API Gateway',
      description:
          'Sistema de gestión de APIs con autenticación y rate limiting',
      technologies: ['Node.js', 'Express', 'Redis', 'JWT'],
      url: 'https://github.com/arturo/api-gateway',
    ),
    const Project(
      name: 'Microservicios E-commerce',
      description: 'Arquitectura de microservicios para plataforma de venta',
      technologies: ['Node.js', 'Docker', 'Kubernetes', 'MongoDB'],
      url: 'https://github.com/arturo/ecommerce-ms',
    ),
    const Project(
      name: 'Sistema de Reservas',
      description: 'Backend para gestión de reservas con integración de pagos',
      technologies: ['Node.js', 'PostgreSQL', 'Stripe', 'WebSockets'],
      url: 'https://github.com/arturo/booking-system',
    ),
    const Project(
      name: 'API de Noticias',
      description: 'API REST para gestión de noticias con caché',
      technologies: ['Node.js', 'Redis', 'Elasticsearch', 'MongoDB'],
      url: 'https://github.com/arturo/news-api',
    ),
  ];

  response.CommandResponse handleCommand(
    String command,
    String currentDirectory,
  ) {
    if (command.startsWith('cd ')) {
      return _handleNavigation(command.substring(3).trim(), currentDirectory);
    }

    switch (command) {
      case 'clear':
        return const response.CommandResponse(content: '');
      case 'cat contacto.txt':
        return const response.CommandResponse(
          content: '''
[Contacto]
Email: arturo@example.com
GitHub: github.com/arturo
LinkedIn: linkedin.com/in/arturo
Teléfono: +1234567890

Escribe "contact [método]" para contactarme (ejemplo: "contact email")
''',
        );
      case 'cat skills.txt':
        return const response.CommandResponse(
          content: '''
[Habilidades Backend]
Node.js - Desarrollo de APIs y microservicios
Express - Framework para APIs REST
MongoDB - Base de datos NoSQL
PostgreSQL - Base de datos relacional
Redis - Caché y mensajería
Docker - Contenedorización
Kubernetes - Orquestación de contenedores
REST/GraphQL - Diseño de APIs
WebSockets - Comunicación en tiempo real
JWT/OAuth - Autenticación y autorización

Escribe "skill [nombre]" para ver detalles (ejemplo: "skill node")
''',
        );
      case 'ls':
        return const response.CommandResponse(
          content: '''
[Directorios]
proyectos/
sobre-mi/

[Archivos]
contacto.txt
skills.txt
''',
        );
      case 'help':
        return const response.CommandResponse(
          content: '''
[Comandos Disponibles]
cd [directorio] - Cambiar directorio (ejemplo: "cd proyectos")
cd .. - Volver al directorio anterior
ls - Listar archivos
cat [archivo] - Mostrar contenido
open [número] - Abrir proyecto (en directorio proyectos)
contact [método] - Contactar por método específico
skill [nombre] - Ver detalles de habilidad
clear - Limpiar la terminal
help - Mostrar esta ayuda
''',
        );
      case 'open 1':
      case 'open 2':
      case 'open 3':
      case 'open 4':
        return _handleOpenProject(command, currentDirectory);
      case 'contact email':
        return const response.CommandResponse(
          content: 'Enviando email a arturo@example.com...',
        );
      case 'contact github':
        return const response.CommandResponse(
          content: 'Redirigiendo a github.com/arturo...',
        );
      case 'contact linkedin':
        return const response.CommandResponse(
          content: 'Redirigiendo a linkedin.com/in/arturo...',
        );
      case 'skill node':
        return const response.CommandResponse(
          content: '''
[Node.js]
• 3 años de experiencia
• Desarrollo de APIs REST y GraphQL
• Arquitectura de microservicios
• Optimización de rendimiento
• Manejo de bases de datos
• Implementación de autenticación
''',
        );
      case 'skill docker':
        return const response.CommandResponse(
          content: '''
[Docker]
• Contenedorización de aplicaciones
• Optimización de imágenes
• Docker Compose
• Integración con CI/CD
• Gestión de volúmenes
• Networking entre contenedores
''',
        );
      default:
        return const response.CommandResponse(
          content:
              'Comando no reconocido. Escribe "help" para ver los comandos disponibles.',
          isError: true,
        );
    }
  }

  response.CommandResponse _handleNavigation(
    String directory,
    String currentDirectory,
  ) {
    switch (directory) {
      case '..':
        if (currentDirectory != '~') {
          return const response.CommandResponse(
            content: 'Volviendo al directorio principal...',
          );
        } else {
          return const response.CommandResponse(
            content: 'Ya estás en el directorio principal',
          );
        }
      case 'proyectos':
        return response.CommandResponse(
          content:
              _projects
                  .map(
                    (project) => '''
[${project.name}]
Descripción: ${project.description}
Tecnologías: ${project.technologies.join(', ')}
Enlace: ${project.url}
''',
                  )
                  .join('\n') +
              '\n\nEscribe "open [número]" para abrir el proyecto (ejemplo: "open 1" para abrir el primer proyecto)',
        );
      case 'sobre-mi':
        return const response.CommandResponse(
          content: '''
[Sobre Mí]
Desarrollador Backend con 3 años de experiencia, especializado en arquitecturas escalables y APIs REST. Experto en optimización de bases de datos y sistemas distribuidos.

[Objetivos]
Diseñar y desarrollar sistemas backend robustos y escalables, implementar arquitecturas de microservicios eficientes y optimizar el rendimiento de APIs.

Escribe "more" para ver más información
''',
        );
      default:
        return const response.CommandResponse(
          content:
              'Directorio no encontrado. Directorios disponibles: proyectos, sobre-mi',
          isError: true,
        );
    }
  }

  response.CommandResponse _handleOpenProject(
    String command,
    String currentDirectory,
  ) {
    if (currentDirectory != '~/proyectos') {
      return const response.CommandResponse(
        content: 'Este comando solo funciona en el directorio de proyectos',
        isError: true,
      );
    }

    final index = int.parse(command.split(' ')[1]) - 1;
    if (index >= 0 && index < _projects.length) {
      final project = _projects[index];
      return response.CommandResponse(
        content: 'Abriendo ${project.name}...\nRedirigiendo a ${project.url}',
      );
    }

    return const response.CommandResponse(
      content: 'Proyecto no encontrado',
      isError: true,
    );
  }
}
