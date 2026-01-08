from isaacsim.core.prims import RigidPrim, GeometryPrim
from pxr import UsdPhysics
import omni.usd

stage = omni.usd.get_context().get_stage()

# 1. Física (Rigid Body)
rigid = RigidPrim("/visual_cube")

# 2. Colisiones (USD + PhysX + collider correcto)
geom = GeometryPrim("/visual_cube")
geom.apply_collision_apis()

# 3 Cambiar la masa
prim = stage.GetPrimAtPath("/visual_cube")
mass_api = UsdPhysics.MassAPI.Apply(prim)
mass_attr = mass_api.GetMassAttr()
mass_attr.Set(75.0)


