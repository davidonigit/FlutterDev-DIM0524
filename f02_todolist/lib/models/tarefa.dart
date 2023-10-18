import 'package:flutter/material.dart';

class Tarefa {
  String id;
  String titulo;
  String descricao;
  String comentario;
  String prioridade;
  DateTime dataCriacao;
  DateTime dataExecucao;
  Color? corPrioridade;


  Tarefa({required this.id, required this.titulo, required this.descricao, required this.comentario, required this.prioridade, required this.dataCriacao, required this.dataExecucao, this.corPrioridade});
}
