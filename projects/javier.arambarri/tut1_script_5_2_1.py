from pxr import UsdPhysics, PhysxSchema
import omni.usd

stage = omni.usd.get_context().get_stage()
prim = stage.GetPrimAtPath("/visual_cube")

# Física (masa)
mass_api = UsdPhysics.MassAPI.Apply(prim)
mass_api.GetMassAttr().Set(55.0)

# Colisiones USD
UsdPhysics.CollisionAPI.Apply(prim)

# Colisiones PhysX
PhysxSchema.PhysxCollisionAPI.Apply(prim)

