from sqlalchemy import Column, Integer, String, Boolean, ForeignKey, DateTime, Float, Time
from sqlalchemy.orm import relationship
from sqlalchemy.types import Date
from datetime import datetime
from .database import Base



# ===================================== C L I E N T E S ========================================
class Cliente(Base):
    __tablename__ = 'clientes'
    id = Column(Integer, primary_key=True, index=True)
    nombre = Column(String(250), index=True)
    apellido = Column(String(255), index=True)
    email = Column(String(250), unique=True, index=True)
    telefono = Column(String(15), index=True)

    # Relaciones
    reservas = relationship("Reserva", back_populates="cliente")
    pedidos = relationship("Pedido", back_populates="cliente")

# ===================================== M E S A S ========================================
class Mesa(Base):
    __tablename__ = 'mesas'
    id = Column(Integer, primary_key=True, index=True)
    numero_mesa = Column(Integer, unique=True, index=True)
    capacidad = Column(Integer)
    disponible = Column(Boolean, default=True)

    # Relaciones
    reservas = relationship("Reserva", back_populates="mesa")
    pedidos = relationship("Pedido", back_populates="mesa")
    cuentas = relationship("Cuenta", back_populates="mesa")
# =================================== R E S E R V A S ========================================
class Reserva(Base):
    __tablename__ = 'reservas'
    id = Column(Integer, primary_key=True, index=True)
    cliente_id = Column(Integer, ForeignKey('clientes.id'))
    mesa_id = Column(Integer, ForeignKey('mesas.id'))
    cuenta_id = Column(Integer, ForeignKey('cuentas.id'))  # Relación con Cuenta
    fecha_reserva = Column(Date)
    hora_reserva = Column(Time)

    # Relaciones
    cliente = relationship("Cliente", back_populates="reservas")
    mesa = relationship("Mesa", back_populates="reservas")
    cuenta = relationship("Cuenta", back_populates="reservas")

# =================================== C O M B O S ========================================
class Combo(Base):
    __tablename__ = 'combos'
    id = Column(Integer, primary_key=True, index=True)
    nombre = Column(String(250), index=True)
    descripcion = Column(String(500))
    precio = Column(Float)
    
    #Relaciones
    pedidos = relationship("Pedido", back_populates="combo")
    ingredientes = relationship("Ingrediente", back_populates="combo")
    
# =================================== B E B I D A S ========================================
class Bebida(Base):
    __tablename__ = 'bebidas'

    id = Column(Integer, primary_key=True, index=True)
    nombre = Column(String(250), index=True)
    precio = Column(Float)
    
    # Relaciones
    pedidos = relationship("Pedido", back_populates="bebida")
# ================================== I N G R E D I E N T E S ========================================
class Ingrediente(Base):
    __tablename__ = 'ingredientes'
    id = Column(Integer, primary_key=True, index=True)
    nombre = Column(String(250), nullable=False)
    combo_id = Column(Integer, ForeignKey('combos.id'))

    # Relaciones
    combo = relationship("Combo", back_populates="ingredientes")

# ================================== P E D I D O S ========================================
class Pedido(Base):
    __tablename__ = 'pedidos'
    id = Column(Integer, primary_key=True, index=True)
    cliente_id = Column(Integer, ForeignKey('clientes.id'))
    mesa_id = Column(Integer, ForeignKey('mesas.id'))
    combo_id = Column(Integer, ForeignKey('combos.id'))
    bebida_id = Column(Integer, ForeignKey('bebidas.id'))
    cant_combo = Column(Integer, default=0) 
    cant_bebida = Column(Integer, default=0)
    fecha_pedido = Column(DateTime, default=datetime.utcnow)
    total_pedido = Column(Float)
    estado = Column(String, default="activo")
    
    # Relaciones
    cliente = relationship("Cliente", back_populates="pedidos")
    mesa = relationship("Mesa", back_populates="pedidos")
    combo = relationship("Combo", back_populates="pedidos")
    bebida = relationship("Bebida", back_populates="pedidos")

# ================================ C U E N T A S ========================================
class Cuenta(Base):
    __tablename__ = 'cuentas'
    id = Column(Integer, primary_key=True, index=True)
    mesa_id = Column(Integer, ForeignKey('mesas.id'))
    fecha_apertura = Column(DateTime, default=datetime.utcnow)
    estado = Column(String(50), default='abierta')
    total = Column(Float, default=0.0)

    # Relaciones
    reservas = relationship("Reserva", back_populates="cuenta")
    mesa = relationship("Mesa", back_populates="cuentas")
    detalles = relationship("DetalleCuenta", back_populates="cuenta")

# =============================== D E T A L L E S  D E  C U E N T A ============================
class DetalleCuenta(Base):
    __tablename__ = 'detalles_cuenta'
    id = Column(Integer, primary_key=True, index=True)
    cuenta_id = Column(Integer, ForeignKey('cuentas.id'))
    producto_id = Column(Integer, ForeignKey('productos.id'))
    tipo_producto = Column(String(50))
    cantidad = Column(Integer, nullable=False)
    precio_unitario = Column(Float, nullable=False)
    subtotal = Column(Float, nullable=False)

    # Relaciones
    cuenta = relationship("Cuenta", back_populates="detalles")

# =============================== D E T A L L E S  D E  P E D I D O ============================