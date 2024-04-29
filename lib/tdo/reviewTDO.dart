class ReviewTDO {

  final int idUsuario;
  final int idProducto;
  final String resena;
  final double calificacion;

  ReviewTDO({ required this.idUsuario, required this.idProducto, required this.resena, required this.calificacion});


  Map<String, dynamic> toMap() {
    return {
      'idUsuario': idUsuario,
      'idProducto': idProducto,
      'resena': resena,
      'calificacion': calificacion
    };
  }


}