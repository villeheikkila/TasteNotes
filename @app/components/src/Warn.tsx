import { redA } from "@radix-ui/colors";
import { styled } from "@stitches/react";
import React from "react";

export interface WarnProps extends React.ComponentProps<typeof DotContainer> {
  children: React.ReactNode;
  okay?: boolean;
}

const Dot = styled("span", {
  height: "8px",
  width: "8px",
  borderRadius: "50%",
  backgroundColor: redA.redA10,
});

const DotContainer = styled("div");

export function Warn({ children, okay }: WarnProps) {
  console.log("okay: ", okay);
  return okay ? (
    <>{children}</>
  ) : (
    <>
      {children} <Dot />
    </>
  );
}
