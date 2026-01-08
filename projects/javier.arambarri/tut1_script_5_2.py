# Solo se añade física (y masa), por lo que el cubo cae
# hasta el infinito y no colisiona con GroundPlane
from pxr import UsdPhysics

prim = stage.GetPrimAtPath("/visual_cube")
mass_api = UsdPhysics.MassAPI.Apply(prim)
mass_api.GetMassAttr().Set(55.0)

