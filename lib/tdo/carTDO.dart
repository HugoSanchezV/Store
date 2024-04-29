class CarTDO {
  final int idUsuario;
  final int idProducto;
  int cantidad;

  CarTDO({required this.idUsuario, required this.idProducto, required this.cantidad});


  Map<String, dynamic> toMap() {
    return {
      'idUsuario': idUsuario,
      'idProducto': idProducto,
      'cantidad': cantidad
    };
  }
}