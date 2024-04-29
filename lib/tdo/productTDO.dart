class ProductTDO {
  final String nombre;
  final String descripcion;
  final String color;
  final String talla;
  final String marca;
  final String img;
  final int cantidad;
  final double precio;
  final int descuento;
  final String categoria;


  ProductTDO({required this.nombre,required this.descripcion,required this.color,required this.talla,required
  this.marca,required this.img,required this.cantidad,required this.precio,required this.descuento, required this.categoria});


  Map<String, dynamic> toMap() {
    return {
      'nombre': nombre,
      'descripcion':descripcion,
      'color':color,
      'talla':talla,
      'marca':marca,
      'img':img,
      'cantidad':cantidad,
      'precio': precio,
      'descuento':descuento
    };
  }
}