#include "geometry/segment2d.hpp"

#include "geometry/robust_orientation.hpp"

#include "std/algorithm.hpp"

namespace m2
{
bool IsPointOnSegment(m2::PointD const & pt, m2::PointD const & p1, m2::PointD const & p2)
{
  // The epsilon here is chosen quite arbitrarily, to pass paranoid
  // tests and to match our real-data geometry precision. If you have
  // better ideas how to check whether pt belongs to (p1, p2) segment
  // more precisely or without kEps, feel free to submit a pull
  // request.
  double const kEps = 1e-100;

  double const t = robust::OrientedS(p1, p2, pt);

  if (fabs(t) > kEps)
    return false;

  double minX = p1.x;
  double maxX = p2.x;
  if (maxX < minX)
    swap(maxX, minX);

  double minY = p1.y;
  double maxY = p2.y;
  if (maxY < minY)
    swap(maxY, minY);

  return pt.x >= minX && pt.x <= maxX && pt.y >= minY && pt.y <= maxY;
}
}  // namespace m2
