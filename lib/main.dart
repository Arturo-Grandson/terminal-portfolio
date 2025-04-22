import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Portafolio de Arturo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.white,
          background: Colors.white,
        ),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> _commandHistory = [];
  final TextEditingController _commandController = TextEditingController();
  final FocusNode _commandFocusNode = FocusNode();
  String _currentDirectory = '~';
  String _currentContent = '';
  bool _showInitialInfo = true;

  @override
  void initState() {
    super.initState();
    _commandFocusNode.requestFocus();
  }

  void _updateDirectoryAndContent(String newDirectory, String content) {
    setState(() {
      _currentDirectory = newDirectory;
      _currentContent = content;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 49, 52, 53),
      body: Center(
        child: Container(
          width: 800,
          height: 900,
          margin: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0xFF071E22),
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 10,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Column(
            children: [
              _buildWindowBar('Terminal'),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (_showInitialInfo) ...[
                                _buildTerminalLine(
                                  'arturo@portfolio:~\$ whoami',
                                  'Arturo',
                                ),
                                const SizedBox(height: 10),
                                _buildTerminalLine(
                                  'arturo@portfolio:~\$ role',
                                  'Desarrollador Backend',
                                ),
                                const SizedBox(height: 10),
                                _buildTerminalLine(
                                  'arturo@portfolio:~\$ about',
                                  '''[SOBRE MÍ] 👦
Desarrollador Backend con 3 años de experiencia, especializado en 
arquitecturas escalables y APIs REST. Experto en optimización de 
bases de datos y sistemas distribuidos.

[OBJETIVOS] 🎯
Diseñar y desarrollar sistemas backend robustos y escalables, 
implementar arquitecturas de microservicios eficientes y optimizar 
el rendimiento de APIs.

[HABILIDADES] 💻
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

[PROYECTOS DESTACADOS] 💻
API Gateway - Sistema de gestión de APIs
Microservicios E-commerce - Arquitectura distribuida
Sistema de Reservas - Backend con WebSockets
API de Noticias - Servicio con caché

Escribe "help" para ver los comandos disponibles''',
                                ),
                                const SizedBox(height: 10),
                              ],
                              if (_currentContent.isNotEmpty) ...[
                                Text(
                                  _currentContent,
                                  style: const TextStyle(
                                    color: Color(0xFF6A993E),
                                    fontFamily: 'monospace',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Text(
                            'arturo@portfolio:$_currentDirectory\$ ',
                            style: const TextStyle(
                              color: Colors.white70,
                              fontFamily: 'monospace',
                              fontSize: 14,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: TextField(
                              controller: _commandController,
                              focusNode: _commandFocusNode,
                              style: const TextStyle(
                                color: Color(0xFF6A993E),
                                fontFamily: 'monospace',
                                fontSize: 14,
                                fontWeight: FontWeight.w300,
                              ),
                              cursorWidth: 8,
                              cursorColor: Colors.white,
                              showCursor: true,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'type a command...',
                                hintStyle: TextStyle(
                                  color: Color.fromARGB(75, 255, 255, 255),
                                  fontFamily: 'monospace',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w300,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                              onSubmitted: _handleCommand,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWindowBar(String title) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: const BoxDecoration(
        color: Color(0xFF2D2D2D),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              _buildWindowButton(Colors.red),
              const SizedBox(width: 6),
              _buildWindowButton(Colors.amber),
              const SizedBox(width: 6),
              _buildWindowButton(Colors.green),
            ],
          ),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white70,
              fontFamily: 'monospace',
              fontSize: 14,
            ),
          ),
          const SizedBox(width: 60),
        ],
      ),
    );
  }

  Widget _buildWindowButton(Color color) {
    return Container(
      width: 12,
      height: 12,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }

  Widget _buildTerminalLine(String command, String response) {
    final List<Widget> children = [
      Text(
        command,
        style: const TextStyle(
          color: Colors.white70,
          fontFamily: 'monospace',
          fontSize: 14,
          fontWeight: FontWeight.w300,
        ),
      ),
    ];

    if (response.isNotEmpty) {
      final lines = response.split('\n');
      for (var i = 0; i < lines.length; i++) {
        final line = lines[i];
        if (line.trim().isEmpty) {
          children.add(const SizedBox(height: 10));
          continue;
        }

        children.add(
          Text(
            line,
            style: TextStyle(
              color:
                  line.contains('[') && line.contains(']')
                      ? Colors.white
                      : const Color(0xFF6A993E),
              fontFamily: 'monospace',
              fontSize: 14,
              fontWeight: FontWeight.w300,
            ),
          ),
        );

        if (i < lines.length - 1) {
          children.add(const SizedBox(height: 5));
        }
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    );
  }

  void _handleCommand(String command) {
    _commandController.clear();
    _commandFocusNode.requestFocus();

    if (command.trim().isEmpty) return;

    setState(() {
      _commandHistory.add(command);
      _showInitialInfo = false;

      // Manejar comandos de navegación
      if (command.startsWith('cd ')) {
        final directory = command.substring(3).trim();

        // Manejar cd ..
        if (directory == '..') {
          if (_currentDirectory == '~') {
            _currentContent = 'Ya estás en el directorio principal';
          } else {
            _currentDirectory = '~';
            _currentContent = '''
            [Directorios]
            📁 proyectos/
            📁 sobre-mi/

            [Archivos]
            📄 contacto.txt
            📄 skills.txt
            ''';
          }
          return;
        }

        // Manejar cd a otros directorios
        switch (directory) {
          case 'proyectos':
            if (_currentDirectory == '~') {
              _currentDirectory = '~/proyectos';
              _currentContent = '''
                [API Gateway]
                Descripción: Sistema de gestión de APIs con autenticación y rate limiting
                Tecnologías: Node.js, Express, Redis, JWT
                Enlace: https://github.com/arturo/api-gateway

                [Microservicios E-commerce]
                Descripción: Arquitectura de microservicios para plataforma de venta
                Tecnologías: Node.js, Docker, Kubernetes, MongoDB
                Enlace: https://github.com/arturo/ecommerce-ms

                [Sistema de Reservas]
                Descripción: Backend para gestión de reservas con integración de pagos
                Tecnologías: Node.js, PostgreSQL, Stripe, WebSockets
                Enlace: https://github.com/arturo/booking-system

                [API de Noticias]
                Descripción: API REST para gestión de noticias con caché
                Tecnologías: Node.js, Redis, Elasticsearch, MongoDB
                Enlace: https://github.com/arturo/news-api

                Escribe "open [número]" para abrir el proyecto (ejemplo: "open 1" para abrir el primer proyecto)
                ''';
            } else {
              _currentContent =
                  'Ya estás en un directorio. Usa "cd .." para volver primero.';
            }
            break;
          case 'sobre-mi':
            if (_currentDirectory == '~') {
              _currentDirectory = '~/sobre-mi';
              _currentContent = '''
                [Sobre Mí] 👦
                Desarrollador Backend con 3 años de experiencia, especializado en arquitecturas escalables y APIs REST. Experto en optimización de bases de datos y sistemas distribuidos.

                [Objetivos] 🎯
                Diseñar y desarrollar sistemas backend robustos y escalables, implementar arquitecturas de microservicios eficientes y optimizar el rendimiento de APIs.

                Escribe "more" para ver más información
                ''';
            } else {
              _currentContent =
                  'Ya estás en un directorio. Usa "cd .." para volver primero.';
            }
            break;
          default:
            _currentContent =
                'Directorio no encontrado. Directorios disponibles: proyectos, sobre-mi';
        }
        return;
      }

      // Resto de comandos
      switch (command) {
        case 'clear':
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const HomePage()),
          );
          return;
        case 'cat contacto.txt':
          _currentContent = '''
            [Contacto]
            📧 Email: arturo@example.com
            👤 GitHub: github.com/arturo
            👔 LinkedIn: linkedin.com/in/arturo
            📱 Teléfono: +1234567890

            Escribe "contact [método]" para contactarme (ejemplo: "contact email")
            ''';
          break;
        case 'cat skills.txt':
          _currentContent = '''
            [Habilidades Backend]
            • Node.js - Desarrollo de APIs y microservicios
            • Express - Framework para APIs REST
            • MongoDB - Base de datos NoSQL
            • PostgreSQL - Base de datos relacional
            • Redis - Caché y mensajería
            • Docker - Contenedorización
            • Kubernetes - Orquestación de contenedores
            REST/GraphQL - Diseño de APIs
            WebSockets - Comunicación en tiempo real
            JWT/OAuth - Autenticación y autorización

            Escribe "skill [nombre]" para ver detalles (ejemplo: "skill node")
            ''';
          break;
        case 'ls':
          _currentContent = '''
            [Directorios]
            📁 proyectos/
            📁 sobre-mi/

            [Archivos]
            📄 contacto.txt
            📄 skills.txt
            ''';
          break;
        case 'help':
          _currentContent = '''
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
            ''';
          break;
        case 'open 1':
          if (_currentDirectory == '~/proyectos') {
            _currentContent =
                'Abriendo API Gateway...\nRedirigiendo a https://github.com/arturo/api-gateway';
          } else {
            _currentContent =
                'Este comando solo funciona en el directorio de proyectos';
          }
          break;
        case 'open 2':
          if (_currentDirectory == '~/proyectos') {
            _currentContent =
                'Abriendo Microservicios E-commerce...\nRedirigiendo a https://github.com/arturo/ecommerce-ms';
          } else {
            _currentContent =
                'Este comando solo funciona en el directorio de proyectos';
          }
          break;
        case 'open 3':
          if (_currentDirectory == '~/proyectos') {
            _currentContent =
                'Abriendo Sistema de Reservas...\nRedirigiendo a https://github.com/arturo/booking-system';
          } else {
            _currentContent =
                'Este comando solo funciona en el directorio de proyectos';
          }
          break;
        case 'open 4':
          if (_currentDirectory == '~/proyectos') {
            _currentContent =
                'Abriendo API de Noticias...\nRedirigiendo a https://github.com/arturo/news-api';
          } else {
            _currentContent =
                'Este comando solo funciona en el directorio de proyectos';
          }
          break;
        case 'contact github':
          _currentContent = 'Redirigiendo a github.com/arturo...';
          break;
        case 'contact linkedin':
          _currentContent = 'Redirigiendo a linkedin.com/in/arturo...';
          break;
        case 'skill node':
          _currentContent = '''
            [Node.js]
            • 3 años de experiencia
            • Desarrollo de APIs REST y GraphQL
            • Arquitectura de microservicios
            • Optimización de rendimiento
            • Manejo de bases de datos
            • Implementación de autenticación
            ''';
          break;
        default:
          _currentContent =
              'Comando no reconocido. Escribe "help" para ver los comandos disponibles.';
      }
    });
  }
}
