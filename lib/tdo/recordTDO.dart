class RecordTDO {
  final String idUsuario;
  final String idProducto;
  final int cantidad;
  final String fecha;
  final double precio;
  final String estado;


  RecordTDO({required this.idUsuario, required this.idProducto, required this.cantidad,required this.fecha, required this.precio, required this.estado});

  Map<String, dynamic> toMap() {
    return {
      'idUsuario': idUsuario,
      'idProducto': idProducto,
      'cantidad': cantidad,
      'fecha': fecha,
      'estado' : estado
    };
  }
}
